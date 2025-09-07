You're asking for the **ultimate DevOps guide to NGINX**—and I love that energy! Let’s turn you into someone who can confidently deploy, configure, secure, and automate NGINX like a pro. I’ll walk you through **everything practical** a DevOps engineer should know, step by step.

---

## 🧱 1. What Is NGINX (In DevOps Terms)

NGINX is more than just a web server. In DevOps, it’s used as:
- **Reverse Proxy**: Routes traffic to backend services.
- **Load Balancer**: Distributes traffic across multiple servers.
- **Static File Server**: Serves HTML, CSS, JS, etc.
- **SSL Termination Point**: Handles HTTPS encryption.
- **Gateway in Kubernetes**: Acts as an ingress controller.

---

## 🛠️ 2. Practical Setup with Docker

### 🔧 Run NGINX in a Container
```bash
docker run -d -p 8080:80 nginx
```

### 📁 Serve Custom HTML
```bash
docker run -d -p 8080:80 -v $(pwd)/site:/usr/share/nginx/html nginx
```
- `site` folder contains your HTML files.
- Bind mount makes it live-editable.

---

## 🔄 3. Reverse Proxy Setup

### 🔧 nginx.conf
```nginx
server {
    listen 80;
    location / {
        proxy_pass http://localhost:3000;
    }
}
```
- This forwards requests from NGINX to your Node.js app on port 3000.

---

## ⚖️ 4. Load Balancing

```nginx
upstream backend {
    server backend1.example.com;
    server backend2.example.com;
}

server {
    listen 80;
    location / {
        proxy_pass http://backend;
    }
}
```
- Distributes traffic between multiple backend servers.

---

## 🔐 5. SSL Setup (Let’s Encrypt + Certbot)

```bash
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d yourdomain.com
```
- Automatically configures HTTPS with free SSL certificates.

---

## 📦 6. CI/CD Integration

### 🧪 Example Jenkins Pipeline
```groovy
pipeline {
  agent any
  stages {
    stage('Deploy NGINX') {
      steps {
        sh 'ansible-playbook deploy_nginx.yml'
      }
    }
  }
}
```
- Automates NGINX deployment using Ansible.

---

## 📊 7. Monitoring & Logging

- **Access Logs**: `/var/log/nginx/access.log`
- **Error Logs**: `/var/log/nginx/error.log`
- Integrate with:
  - **Prometheus + Grafana** for metrics
  - **ELK Stack** (Elasticsearch, Logstash, Kibana) for log analysis

---

## 🧠 8. Infrastructure as Code (IaC)

### 🔧 Ansible Playbook
```yaml
- hosts: web
  become: yes
  tasks:
    - name: Install NGINX
      apt:
        name: nginx
        state: present

    - name: Copy config
      template:
        src: nginx.conf.j2
        dest: /etc/nginx/nginx.conf

    - name: Restart NGINX
      service:
        name: nginx
        state: restarted
```

---

## 🚀 9. Kubernetes Ingress Controller

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-ingress
spec:
  rules:
  - host: myapp.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: my-service
            port:
              number: 80
```
- NGINX routes traffic to your Kubernetes services.

---

## 📚 Want More?

Here are two **practical resources** you’ll love:
- [NGINX Handbook for DevOps Engineers](https://www.amazon.in/NGINX-Handbook-Practical-Developers-DevOps/dp/B0FL7XK2F4) – A complete guide with real-world use cases.
- [GitHub: nginx-for-devops](https://github.com/AdityaJareda/nginx-for-devops) – Step-by-step examples for reverse proxy, SSL, cloud deployment, and more.

---

Let me know if you want a **hands-on project** like:
- Deploying a Node.js app with NGINX reverse proxy
- Setting up SSL with Docker
- Automating NGINX with Ansible

We’ll build it together. You’re on your way to mastering NGINX like a true DevOps engineer.

## Overview

You’ve listed the five core things NGINX does in DevOps. Below, I’ll explain each one in practical terms: what it is, why you use it, a minimal working config, how to test it, which logs/metrics to watch, and common pitfalls.

---

## Reverse proxy

- **What:** NGINX sits in front of your app and forwards requests to it (and returns responses back to clients).
- **Why:** Hides your app servers, centralizes TLS/security, adds caching/rate-limits, rewrites paths/headers, and simplifies blue/green/canary rollouts.

#### Minimal config
```nginx
server {
  listen 80;
  server_name _;
  location / {
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_pass http://127.0.0.1:3000;
    proxy_read_timeout 60s;
    proxy_connect_timeout 5s;
  }
}
```

#### How to test
- **Start backend:** `node app.js` (on 3000) or any app.
- **Hit NGINX:** `curl -i http://localhost/`
- **Check headers at backend:** Confirm `X-Forwarded-*` arrive.

#### Logs and metrics
- **Access log:** status, latency: add `$request_time`, `$upstream_response_time`, `$upstream_addr`.
- **Error log:** upstream timeouts, 502/504, DNS issues.
- **Key metrics:** p95 `$request_time`, 5xx rate, upstream error rate.

#### Pitfalls
- **Wrong Host header:** missing `proxy_set_header Host $host;`
- **Client IP lost:** missing `X-Forwarded-For`; if behind another proxy, configure real IP module.
- **502/504:** backend down/slow; tune timeouts, health-check backend.

---

## Load balancer

- **What:** Splits traffic across multiple backend instances.
- **Why:** High availability, horizontal scaling, resilience, smoother deploys.

#### Minimal config
```nginx
upstream api {
  server 10.0.0.11:3000 max_fails=3 fail_timeout=10s;
  server 10.0.0.12:3000 max_fails=3 fail_timeout=10s;
  # least_conn;   # alternative algorithm
  # ip_hash;      # simple sticky sessions by client IP
}

server {
  listen 80;
  location / {
    proxy_pass http://api;
    proxy_next_upstream error timeout http_502 http_503;
  }
}
```

#### How to test
- **Loop requests:** `for i in {1..6}; do curl -s http://localhost/; done`
- **Observe distribution:** Backend logs or include `$upstream_addr` in access logs.

#### Logs and metrics
- **Access log fields:** `$upstream_addr`, `$upstream_status`, `$upstream_response_time`.
- **Metrics:** error/timeout rate per upstream, p95/p99 upstream latency, active connections.

#### Pitfalls
- **One bad node drags SLA:** use health checks (app-level) and next-upstream.
- **Session stickiness:** for stateful apps, use `ip_hash` or a cookie-based approach.
- **Uneven load:** consider `least_conn` for long-lived requests.

---

## Static file server

- **What:** Serve HTML, CSS, JS, images directly from NGINX.
- **Why:** Extremely fast, low resource, offloads work from app servers.

#### Minimal config
```nginx
server {
  listen 80;
  root /var/www/site;   # your built static site
  index index.html;

  include /etc/nginx/mime.types;

  gzip on;
  gzip_types text/plain text/css application/javascript application/json image/svg+xml;

  location ~* \.(js|css|png|jpg|jpeg|gif|svg)$ {
    expires 30d;
    add_header Cache-Control "public, max-age=2592000, immutable";
  }

  # SPA fallback (optional)
  location / {
    try_files $uri /index.html;
  }
}
```

#### How to test
- **Headers:** `curl -I http://localhost/main.css` → check `Cache-Control`, `Content-Type`, `Content-Encoding: gzip`.

#### Logs and metrics
- **Access log:** bytes sent, cache hits (if using proxy_cache), status codes.
- **Metrics:** bandwidth, 404s for missing assets.

#### Pitfalls
- **Wrong MIME:** missing `mime.types` → broken CSS/JS.
- **Aggressive caching:** set long TTL only for hashed filenames.

---

## SSL termination point (HTTPS)

- **What:** NGINX handles TLS handshake and certificates; forwards plain HTTP to your app.
- **Why:** Centralizes encryption, offloads CPU, simplifies app config, enables HSTS and modern ciphers.

#### Minimal config
```nginx
server {
  listen 80;
  server_name example.com www.example.com;
  return 301 https://$host$request_uri;
}

server {
  listen 443 ssl http2;
  server_name example.com www.example.com;

  ssl_certificate     /etc/letsencrypt/live/example.com/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;

  add_header Strict-Transport-Security "max-age=31536000" always;

  location / {
    proxy_pass http://127.0.0.1:3000;
  }
}
```

#### How to test
- **TLS check:** `curl -I https://example.com` (expect 200) and `curl -I http://example.com` (expect 301 to https).
- **Certificates:** use an SSL tester or `openssl s_client -connect example.com:443`.

#### Logs and metrics
- **Access log:** track 301s (HTTP→HTTPS) and 200s on 443.
- **Error log:** cert path/permissions, expired certs, handshake errors.
- **Metrics:** TLS handshake failures, cipher usage, 301 ratio.

#### Pitfalls
- **Expired/incorrect cert path:** confirm permissions and renewals (Certbot timer).
- **Mixed content:** app must load assets via HTTPS.

---

## Gateway in Kubernetes (Ingress controller)

- **What:** The NGINX Ingress Controller runs inside your cluster and routes external traffic to Services via Ingress objects.
- **Why:** Single entry point, path/host-based routing, TLS termination, request policies (rate limits, body size), canary strategies.

#### Minimal setup
- **Install controller (Helm example):**
  ```bash
  helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
  helm install ingress ingress-nginx/ingress-nginx -n ingress-nginx --create-namespace
  ```
- **Create an Ingress:**
  ```yaml
  apiVersion: networking.k8s.io/v1
  kind: Ingress
  metadata:
    name: app-ingress
    annotations:
      nginx.ingress.kubernetes.io/proxy-body-size: "10m"
  spec:
    ingressClassName: nginx
    rules:
    - host: app.example.com
      http:
        paths:
        - path: /
          pathType: Prefix
          backend:
            service:
              name: app-svc
              port:
                number: 80
  ```

#### How to test
- **DNS:** point `app.example.com` to the controller’s LoadBalancer IP.
- **Request:** `curl -I https://app.example.com` (if TLS configured via cert-manager or secret).

#### Logs and metrics
- **Controller logs:** `kubectl logs -n ingress-nginx deploy/ingress-nginx-controller`
- **Access-like logs:** configurable via Helm values; export to your logging stack.
- **Metrics:** controller exposes Prometheus metrics; monitor 4xx/5xx, p95 latency.

#### Pitfalls
- **Wrong Service port/selector:** Ingress 404 or 502; verify Service matches Deployment.
- **Missing TLS secret/cert-manager config:** handshake errors.

---

## Logging and observability (use these across roles)

- **Access log format (recommended):**
  ```nginx
  log_format main_ext
    '$remote_addr $host "$request" $status $body_bytes_sent '
    'rt=$request_time urt=$upstream_response_time ua="$upstream_addr" '
    'ref="$http_referer" agent="$http_user_agent"';
  access_log /var/log/nginx/access.log main_ext;
  error_log /var/log/nginx/error.log warn;
  ```
- **Ship logs:** Filebeat/Fluent Bit → ELK/OpenSearch; or Docker log drivers.
- **Rotate logs:** logrotate with `kill -USR1 $(cat /run/nginx.pid)` post-rotate.
- **Dashboards/alerts:**
  - **Alerts:** 5xx rate > 2% (5m), p95 `request_time` > 1s, surge in 4xx.
  - **Dashboards:** status code trends, latency heatmaps, upstream error rates.

---

## Quick “what to use when” summary

- **Reverse proxy:** One app behind NGINX for security, headers, URL rewrites, caching.
- **Load balancer:** Multiple app instances; HA and scale-out.
- **Static server:** Build artifacts or SPA assets; fastest delivery and caching.
- **SSL termination:** Centralize HTTPS; HSTS, HTTP/2/3, modern ciphers.
- **K8s ingress:** Unified entry for many Services; policies and TLS at cluster edge.

If you tell me your environment (bare-metal, Docker, or Kubernetes) and your app stack, I’ll give you a ready-to-run config tailored to you and a checklist to verify it in production.
