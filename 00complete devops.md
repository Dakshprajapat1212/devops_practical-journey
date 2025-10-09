# End-to-end devops for an ecommerce platform

You’re asking for a real, practical walkthrough—how the code is organized (with comments for logic and connections), how we containerize it, build images, deploy on Kubernetes, manage infra with Terraform, config with Ansible, wire CI/CD, and handle DNS and routing. This is a complete, production-style flow you can adapt.

---

## Architecture overview

- **App tiers:**
  - **Frontend:** React/Next.js serving the web store.
  - **APIs:** User service, Catalog service, Cart service, Order service, Payment service.
  - **Data stores:** PostgreSQL (orders/users), Redis (sessions/cart), Kafka or SQS (events), MinIO/S3 (assets).
- **Cross-cutting:** Auth, observability (Prometheus/Grafana), centralized logging (Loki/ELK), feature flags, rate limiting (API gateway).
- **Infra:** Cloud VPC, subnets, EKS (K8s), managed DB or self-hosted DB StatefulSets, Ingress + DNS.

---

## Code structure with comment-only logic

```text
ecommerce/
├─ frontend/                 # React/Next.js storefront
│  ├─ pages/
│  ├─ components/
│  └─ src/services/api.ts    # // calls backend APIs through API gateway
├─ services/
│  ├─ user-service/
│  │  ├─ src/index.ts        # // HTTP server: signup/login, JWT issue/verify
│  │  ├─ src/routes/*.ts     # // /users, /auth endpoints
│  │  ├─ src/db.ts           # // connects to PostgreSQL via env: POSTGRES_URI
│  │  └─ src/events.ts       # // publishes user-created events to Kafka
│  ├─ catalog-service/
│  │  ├─ src/index.ts        # // product listing/search
│  │  ├─ src/repo.ts         # // reads products from DB or cache (Redis)
│  │  └─ src/events.ts       # // emits product-updated to Kafka
│  ├─ cart-service/
│  │  ├─ src/index.ts        # // cart CRUD, uses Redis for fast access
│  │  └─ src/checkout.ts     # // calls order-service to create order
│  ├─ order-service/
│  │  ├─ src/index.ts        # // creates orders, updates status
│  │  ├─ src/db.ts           # // connects to PostgreSQL orders DB
│  │  └─ src/worker.ts       # // consumes "payment-success" events from Kafka
│  ├─ payment-service/
│  │  ├─ src/index.ts        # // initiates payment, webhook handler
│  │  └─ src/gateway.ts      # // connects to payment provider with API key
│  └─ api-gateway/
│     ├─ src/index.ts        # // routes requests to services, rate limits, auth check
│     └─ src/routes/*.ts     # // /api/users, /api/catalog, /api/cart...
├─ libs/
│  ├─ auth/                  # // JWT utilities, middleware for services
│  ├─ events/                # // Kafka producer/consumer setup
│  └─ observability/         # // OpenTelemetry tracer, Prom metrics
├─ deploy/
│  ├─ k8s/                   # // raw manifests (dev)
│  ├─ helm/                  # // charts (prod)
│  ├─ terraform/             # // infra: VPC, EKS, RDS, Route53, etc.
│  ├─ ansible/               # // config mgmt, secrets bootstrap, bastion setup
│  └─ ci-cd/                 # // GitHub Actions pipelines
└─ ops/
   ├─ runbooks/              # // incident response steps
   └─ dashboards/            # // Grafana JSON, alerts
```

---

## Containerization and images

#### Dockerfiles (comments explain logic)

```dockerfile
# services/user-service/Dockerfile
# Base with Node runtime
FROM node:20-alpine

# Create app directory
WORKDIR /usr/src/app

# Install deps separately to leverage layer caching
COPY package.json package-lock.json ./
RUN npm ci --only=production

# Copy source
COPY src ./src

# Env-driven config (12-factor): DB URL, JWT secret
# EXPOSE runtime port
EXPOSE 8080

# Healthcheck (optional)
HEALTHCHECK --interval=30s --timeout=3s CMD wget -qO- http://localhost:8080/health || exit 1

# Start
CMD ["node", "src/index.js"]
```

```dockerfile
# services/order-service/Dockerfile
FROM node:20-alpine
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm ci --only=production
COPY src ./src
EXPOSE 8081
CMD ["node", "src/index.js"]
```

```dockerfile
# frontend/Dockerfile
# Build stage
FROM node:20-alpine AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

# Run stage (nginx serving static build)
FROM nginx:alpine
COPY --from=build /app/out /usr/share/nginx/html
EXPOSE 80
```

#### Build and push

```bash
# Build images
docker build -t registry.example.com/ecommerce/user-service:v1 ./services/user-service
docker build -t registry.example.com/ecommerce/order-service:v1 ./services/order-service
docker build -t registry.example.com/ecommerce/frontend:v1 ./frontend

# Push to registry (ECR/GCR/Harbor)
docker push registry.example.com/ecommerce/user-service:v1
docker push registry.example.com/ecommerce/order-service:v1
docker push registry.example.com/ecommerce/frontend:v1
```

---

## Kubernetes manifests and Helm

#### Base K8s manifests (dev)

```yaml
# deploy/k8s/ns.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: ecommerce
```

```yaml
# deploy/k8s/user-deploy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: user-service
  namespace: ecommerce
spec:
  replicas: 3  # // scale horizontally for stateless service
  selector:
    matchLabels: { app: user-service }
  template:
    metadata:
      labels: { app: user-service }
    spec:
      containers:
      - name: user
        image: registry.example.com/ecommerce/user-service:v1
        ports:
        - containerPort: 8080
        env:
        - name: POSTGRES_URI      # // connection string from Secret
          valueFrom:
            secretKeyRef:
              name: user-db-secret
              key: POSTGRES_URI
        - name: JWT_SECRET        # // auth key
          valueFrom:
            secretKeyRef:
              name: auth-secret
              key: JWT_SECRET
        readinessProbe:           # // remove from endpoints until ready
          httpGet:
            path: /ready
            port: 8080
        livenessProbe:            # // restart if stuck
          httpGet:
            path: /health
            port: 8080
        resources:                # // enforce SLOs
          requests: { cpu: "100m", memory: "128Mi" }
          limits:   { cpu: "500m", memory: "512Mi" }
```

```yaml
# deploy/k8s/user-svc.yaml
apiVersion: v1
kind: Service
metadata:
  name: user-service
  namespace: ecommerce
spec:
  selector: { app: user-service }
  ports:
  - port: 80         # // stable cluster port
    targetPort: 8080 # // container port
```

```yaml
# deploy/k8s/ingress.yaml (Nginx or ALB Ingress)
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ecommerce-ingress
  namespace: ecommerce
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/use-regex: "true"
    nginx.ingress.kubernetes.io/proxy-body-size: "20m"
spec:
  tls:
  - hosts:
    - shop.example.com
    secretName: tls-secret            # // cert for HTTPS
  rules:
  - host: shop.example.com
    http:
      paths:
      - path: /api/users(/|$)
        pathType: Prefix
        backend:
          service:
            name: user-service
            port: { number: 80 }
      - path: /api/orders(/|$)
        pathType: Prefix
        backend:
          service:
            name: order-service
            port: { number: 80 }
      - path: /
        pathType: Prefix
        backend:
          service:
            name: frontend
            port: { number: 80 }
```

#### Secrets and config

```yaml
# deploy/k8s/secrets.yaml
apiVersion: v1
kind: Secret
metadata:
  name: user-db-secret
  namespace: ecommerce
type: Opaque
stringData:
  POSTGRES_URI: "postgres://user:pass@postgresql:5432/users"

---
apiVersion: v1
kind: Secret
metadata:
  name: auth-secret
  namespace: ecommerce
type: Opaque
stringData:
  JWT_SECRET: "super-secret-key"
```

#### Helm (prod)

```yaml
# deploy/helm/values.yaml
global:
  domain: shop.example.com

user-service:
  image: registry.example.com/ecommerce/user-service:v1
  replicas: 4
  resources:
    requests: { cpu: 200m, memory: 256Mi }
    limits:   { cpu: 1,    memory: 1Gi }
  env:
    POSTGRES_URI: secretRef:user-db-secret:POSTGRES_URI
    JWT_SECRET:   secretRef:auth-secret:JWT_SECRET
  autoscaling:
    enabled: true
    minReplicas: 3
    maxReplicas: 10
    targetCPUUtilizationPercentage: 60
```

---

## Infrastructure with Terraform

#### Provision VPC, EKS, RDS, Route53

```hcl
# deploy/terraform/main.tf
terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
}
provider "aws" { region = "ap-south-1" } # // Mumbai for Jaipur latencies

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  name    = "ecommerce-vpc"
  cidr    = "10.0.0.0/16"
  azs     = ["ap-south-1a", "ap-south-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.10.0/24", "10.0.11.0/24"]
  enable_nat_gateway = true
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "ecommerce-eks"
  cluster_version = "1.29"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets

  eks_managed_node_groups = {
    app = {
      instance_types = ["t3.large"]
      desired_size   = 3
      min_size       = 2
      max_size       = 8
    }
  }
}

resource "aws_db_instance" "users" {
  engine            = "postgres"
  instance_class    = "db.t3.medium"
  allocated_storage = 50
  name              = "users"
  username          = "user"
  password          = var.db_password
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  db_subnet_group_name   = aws_db_subnet_group.db.name
  skip_final_snapshot    = true
}

resource "aws_db_subnet_group" "db" {
  name       = "ecommerce-db"
  subnet_ids = module.vpc.private_subnets
}

resource "aws_route53_zone" "main" { name = "example.com" }

resource "aws_route53_record" "shop" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "shop.example.com"
  type    = "A"
  alias {
    name                   = aws_lb.ingress.dns_name   # // ALB from ingress controller
    zone_id                = aws_lb.ingress.zone_id
    evaluate_target_health = true
  }
}
```

---

## Configuration with Ansible

- **Use cases:**
  - **Bootstrap bastion** for kubectl/helm access.
  - **Distribute app Secrets** from Vault onto K8s (via `kubectl` or `kubernetes.core`).
  - **Configure Nginx Ingress** values or logging agents (DaemonSets).

```yaml
# deploy/ansible/bootstrap.yml
- name: Bootstrap bastion and cluster tools
  hosts: bastion
  become: true
  tasks:
  - name: Install kubectl and helm
    package:
      name: "{{ item }}"
      state: present
    loop:
      - kubectl
      - helm

  - name: Login to container registry
    shell: |
      aws ecr get-login-password --region ap-south-1 | \
      docker login --username AWS --password-stdin {{ ecr_url }}

  - name: Apply base namespace and secrets
    kubernetes.core.k8s:
      state: present
      definition: "{{ lookup('file', '../k8s/ns.yaml') }}"
  - name: Create secrets (from Ansible Vault)
    kubernetes.core.k8s:
      state: present
      definition:
        apiVersion: v1
        kind: Secret
        metadata: { name: auth-secret, namespace: ecommerce }
        type: Opaque
        stringData:
          JWT_SECRET: "{{ vault_jwt_secret }}"
```

---

## CI/CD pipelines

#### GitHub Actions for build, test, push, deploy

```yaml
# deploy/ci-cd/github-actions.yaml
name: ecommerce-ci-cd

on:
  push:
    branches: [ "main" ]
    paths:
      - "services/**"
      - "frontend/**"
      - "deploy/**"
  pull_request:

jobs:
  build-test:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout
      uses: actions/checkout@v4

    - name: Setup Node
      uses: actions/setup-node@v4
      with: { node-version: "20" }

    - name: Install deps and test (services)
      run: |
        for d in services/*; do
          [ -f "$d/package.json" ] && (cd "$d" && npm ci && npm test) || true
        done

    - name: Build Docker images
      run: |
        echo "${{ secrets.AWS_ECR_PASSWORD }}" | docker login -u AWS --password-stdin ${{ secrets.AWS_ECR_URL }}
        docker build -t ${{ secrets.AWS_ECR_URL }}/ecommerce/user-service:${{ github.sha }} services/user-service
        docker build -t ${{ secrets.AWS_ECR_URL }}/ecommerce/order-service:${{ github.sha }} services/order-service
        docker build -t ${{ secrets.AWS_ECR_URL }}/ecommerce/frontend:${{ github.sha }} frontend
        docker push ${{ secrets.AWS_ECR_URL }}/ecommerce/user-service:${{ github.sha }}
        docker push ${{ secrets.AWS_ECR_URL }}/ecommerce/order-service:${{ github.sha }}
        docker push ${{ secrets.AWS_ECR_URL }}/ecommerce/frontend:${{ github.sha }}

  deploy:
    needs: build-test
    runs-on: ubuntu-latest
    environment: production
    steps:
    - name: Checkout
      uses: actions/checkout@v4

    - name: Setup kubectl
      uses: azure/setup-kubectl@v4
      with: { version: "latest" }

    - name: Configure kubeconfig
      run: |
        aws eks update-kubeconfig --name ecommerce-eks --region ap-south-1

    - name: Helm deploy
      run: |
        helm upgrade --install user-service deploy/helm/user-service \
          --namespace ecommerce \
          --set image.repository=${{ secrets.AWS_ECR_URL }}/ecommerce/user-service \
          --set image.tag=${{ github.sha }}
        helm upgrade --install order-service deploy/helm/order-service \
          --namespace ecommerce \
          --set image.repository=${{ secrets.AWS_ECR_URL }}/ecommerce/order-service \
          --set image.tag=${{ github.sha }}
        helm upgrade --install frontend deploy/helm/frontend \
          --namespace ecommerce \
          --set image.repository=${{ secrets.AWS_ECR_URL }}/ecommerce/frontend \
          --set image.tag=${{ github.sha }}
```

- **Branching strategy:** feature branches → PR → CI (tests, lint, SAST) → merge to main → deploy to staging → manual approval → prod.
- **Security gates:** image scanning (Trivy), SBOM, secret detection (Gitleaks), dependency audit.

---

## DNS, ingress, and routing

- **DNS:** Route53 zone `example.com` with record `shop.example.com` pointing to Ingress Load Balancer.
- **TLS:** CertManager issues/renews certificates, Ingress attaches TLS secret for HTTPS.
- **Routing:**
  - Ingress rules map paths to services: `/api/users` → user-service, `/api/orders` → order-service, `/` → frontend.
  - **API Gateway** enforces auth (JWT), rate limits, and forwards to internal services via ClusterIP.
- **Service discovery:** Services are reachable by DNS inside cluster: `user-service.ecommerce.svc.cluster.local`.
- **Programmatic routing inside gateway:**

```ts
// services/api-gateway/src/index.ts
// // Express server that checks JWT, routes paths, and applies rate limiting
app.use(authMiddleware) // // verify JWT on /api/*
app.use('/api/users', proxy('http://user-service.ecommerce.svc.cluster.local'))
app.use('/api/orders', proxy('http://order-service.ecommerce.svc.cluster.local'))
app.use('/api/catalog', proxy('http://catalog-service.ecommerce.svc.cluster.local'))
// // Frontend is served by Ingress path "/" to frontend Service
```

---

## Observability and ops

- **Metrics:** Prometheus scrape via ServiceMonitor; Grafana dashboards for p95 latency, error rate, throughput.
- **Logs:** Loki or ELK via DaemonSet collecting container stdout.
- **Tracing:** OpenTelemetry SDK in services, OTEL Collector exporting to Jaeger/Tempo.
- **Alerts:** Alertmanager rules (high 5xx rate, CPU throttling, DB connection errors).
- **Scalability:** HPA based on CPU/RPS, PodDisruptionBudgets, readiness gates.
- **Reliability:** Rolling updates, canary via Helm values, blue/green for frontend.

---

## Practical runbook (step-by-step)

1. **Code and local dev**
   - **Write services with env-based config** and health endpoints.
   - **Run locally with Docker Compose** for quick integration testing.
2. **Containerize**
   - **Create Dockerfiles** with clear separation (dependencies, source).
   - **Build images** and push to registry.
3. **Infra provisioning**
   - **Terraform apply** to create VPC, EKS, RDS, Route53.
   - **Install Ingress Controller** (helm), **CertManager**, **ExternalDNS**.
4. **Configuration management**
   - **Ansible** to bootstrap bastion, apply base namespaces/secrets, install agents.
5. **Kubernetes deployment**
   - **kubectl/helm** to deploy services, services, ingress, secrets, configmaps.
   - **Verify** with `kubectl get pods`, `kubectl logs`, `kubectl port-forward`.
6. **CI/CD**
   - **GitHub Actions** builds, tests, scans, pushes images, and runs Helm upgrades.
   - **Staging → Prod** with approvals and versioned releases.
7. **DNS and HTTPS**
   - **Route53** record points to Ingress LB; **CertManager** automates TLS.
   - **Ingress rules** ensure correct path-based routing.
8. **Observability**
   - **Install Prom/Grafana/Loki**; wire OTEL; set alerts; validate dashboards.
9. **Scale and resilience**
   - **Tune HPA**, **add PDBs**, **resource requests/limits**, **graceful shutdown**.
10. **Security**
    - **RBAC**, **NetworkPolicies** (restrict cross-namespace traffic), **Secrets** (KMS integration), **image scanning**.

---

## What you’ll validate, hands-on

- **Connectivity:** `curl https://shop.example.com/api/users/health` returns 200 through Ingress.
- **Service discovery:** `nslookup user-service.ecommerce.svc.cluster.local` inside a Pod.
- **DB wiring:** Check envs in Pod: `echo $POSTGRES_URI`, run migrations job.
- **Scaling:** `kubectl get hpa -n ecommerce`, generate load, watch replicas increase.
- **Zero-downtime deploys:** Push code → pipeline → Helm upgrade → Ingress keeps serving.
- **TLS/DNS:** Certificate status via `kubectl describe certificate tls-secret`.

---

If you want, I’ll tailor this to your exact stack (language, cloud, payment provider) and produce runnable repo scaffolding with Makefiles, Helm charts, and minimal service code stubs you can build today.
