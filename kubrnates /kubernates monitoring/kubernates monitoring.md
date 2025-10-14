https://github.com/iam-veeramalla/observability-zero-to-hero/tree/main/day-2
check github 



today we are gonna monitor minikube k8s using prothomsmeus and visulisee through grafana



check that git readme








Great question, Daksh 👌.  
Kubernetes monitoring is not just a “nice-to-have”—it’s the **eyes and ears of your cluster**. Without it, you’re basically flying blind. Let me break it down step by step:

---

## 🎯 Why We Use Kubernetes Monitoring

- **Pod & Node Health** 🩺  
  - Check if pods are running, restarting, or stuck in `CrashLoopBackOff`.  
  - Monitor node CPU, memory, and disk usage to avoid resource starvation.

- **Application Performance** ⚡  
  - Track request latency, error rates, and throughput.  
  - Helps you know if your service is actually serving traffic smoothly.

- **Autoscaling Decisions** 📈  
  - Horizontal Pod Autoscaler (HPA) relies on metrics like CPU/memory usage.  
  - Without monitoring, scaling rules can’t work properly.

- **Debugging & Root Cause Analysis** 🔍  
  - When something breaks, logs and metrics tell you *why*.  
  - Example: sudden spike in 500 errors → trace back to pod logs → find DB connection issue.

- **Traffic Flow & Service Discovery** 🌐  
  - Monitor how requests move through Services, Ingress, and Pods.  
  - Detect bottlenecks (e.g., one pod getting all traffic due to misconfigured labels).

- **Alerting & Reliability** 🚨  
  - Set alerts for high CPU, pod crashes, or failed deployments.  
  - Ensures you catch issues before users complain.

- **Capacity Planning** 📊  
  - Historical metrics help you decide when to add nodes or optimize workloads.  
  - Prevents over-provisioning (wasting money) or under-provisioning (downtime).

---

## 🛠️ Common Tools for Kubernetes Monitoring

| Tool | Purpose |
|------|---------|
| **Prometheus** | Collects metrics (CPU, memory, request counts). |
| **Grafana** | Visualizes metrics with dashboards. |
| **ELK / EFK Stack** | Centralized logging (Elasticsearch + Fluentd/Fluentbit + Kibana). |
| **Kube-state-metrics** | Exposes cluster object states (deployments, pods, nodes). |
| **Jaeger / Zipkin** | Distributed tracing for microservices. |

---

## 🔑 Simple Analogy (in Hindi for clarity)

सोचो Kubernetes cluster एक **hospital** है:  
- Pods = मरीज (patients)  
- Nodes = वार्ड (wards)  
- Services = नर्स/डॉक्टर जो मरीज तक पहुँचते हैं  
- Monitoring = **CCTV + मेडिकल रिपोर्ट्स**  

अगर monitoring नहीं होगी, तो आपको पता ही नहीं चलेगा कि कौन सा मरीज बीमार है, कौन सा वार्ड भरा हुआ है, और कौन सी दवा काम नहीं कर रही।

---

👉 

## 🏠 Prometheus Architecture
- The architecture of Prometheus is designed to be highly flexible, scalable, and modular.
- It consists of several core components, each responsible for a specific aspect of the monitoring process.

![Prometheus Architecture](images/prometheus-architecture.gif)

### 🔥 Prometheus Server
- Prometheus server is the core of the monitoring system. It is responsible for scraping metrics from various configured targets, storing them in its time-series database (TSDB), and serving queries through its HTTP API.
- Components:
    - **Retrieval**: This module handles the scraping of metrics from endpoints, which are discovered either through static configurations or dynamic service discovery methods.
    - **TSDB (Time Series Database)**: The data scraped from targets is stored in the TSDB, which is designed to handle high volumes of time-series data efficiently.
    - **HTTP Server**: This provides an API for querying data using PromQL, retrieving metadata, and interacting with other components of the Prometheus ecosystem.
- **Storage**: The scraped data is stored on local disk (HDD/SSD) in a format optimized for time-series data.

### 🌐 Service Discovery
- Service discovery automatically identifies and manages the list of scrape targets (i.e., services or applications) that Prometheus monitors.
- This is crucial in dynamic environments like Kubernetes where services are constantly being created and destroyed.
- Components:
    - **Kubernetes**: In Kubernetes environments, Prometheus can automatically discover services, pods, and nodes using Kubernetes API, ensuring it monitors the most up-to-date list of targets.
    - **File SD (Service Discovery)**: Prometheus can also read static target configurations from files, allowing for flexibility in environments where dynamic service discovery is not used.

### 📤 Pushgateway
- The Pushgateway is used to expose metrics from short-lived jobs or applications that cannot be scraped directly by Prometheus.
- These jobs push their metrics to the Pushgateway, which then makes them available for Prometheus to scrape(pull).
- Use Case:
    - It's particularly useful for batch jobs or tasks that have a limited lifespan and would otherwise not have their metrics collected.

### 🚨 Alertmanager
- The Alertmanager is responsible for managing alerts generated by the Prometheus server.
- It takes care of deduplicating, grouping, and routing alerts to the appropriate notification channels such as PagerDuty, email, or Slack.

### 🧲 Exporters
- Exporters are small applications that collect metrics from various third-party systems and expose them in a format Prometheus can scrape. They are essential for monitoring systems that do not natively support Prometheus.
- Types of Exporters:
    - Common exporters include the Node Exporter (for hardware metrics), the MySQL Exporter (for database metrics), and various other application-specific exporters.

### 🖥️ Prometheus Web UI
- The Prometheus Web UI allows users to explore the collected metrics data, run ad-hoc PromQL queries, and visualize the results directly within Prometheus.
### 📊 Grafana
- Grafana is a powerful dashboard and visualization tool that integrates with Prometheus to provide rich, customizable visualizations of the metrics data.

### 🔌 API Clients
- API clients interact with Prometheus through its HTTP API to fetch data, query metrics, and integrate Prometheus with other systems or custom applications.

# 🛠️  Installation & Configurations
## 📦 Step 1: Create EKS Cluster

### Prerequisites
- Download and Install AWS Cli - Please Refer [this]("https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html") link.
- Setup and configure AWS CLI using the `aws configure` command.
- Install and configure eksctl using the steps mentioned [here]("https://eksctl.io/installation/").
- Install and configure kubectl as mentioned [here]("https://kubernetes.io/docs/tasks/tools/").


```bash
eksctl create cluster --name=observability \
                      --region=us-east-1 \
                      --zones=us-east-1a,us-east-1b \
                      --without-nodegroup
```
```bash
eksctl utils associate-iam-oidc-provider \
    --region us-east-1 \
    --cluster observability \
    --approve
```
```bash
eksctl create nodegroup --cluster=observability \
                        --region=us-east-1 \
                        --name=observability-ng-private \
                        --node-type=t3.medium \
                        --nodes-min=2 \
                        --nodes-max=3 \
                        --node-volume-size=20 \
                        --managed \
                        --asg-access \
                        --external-dns-access \
                        --full-ecr-access \
                        --appmesh-access \
                        --alb-ingress-access \
                        --node-private-networking

# Update ./kube/config file
aws eks update-kubeconfig --name observability
```

### 🧰 Step 2: Install kube-prometheus-stack
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

### 🚀 Step 3: Deploy the chart into a new namespace "monitoring"
```bash
kubectl create ns monitoring
```
```bash
cd day-2

helm install monitoring prometheus-community/kube-prometheus-stack \
-n monitoring \
-f ./custom_kube_prometheus_stack.yml
```

### ✅ Step 4: Verify the Installation
```bash
kubectl get all -n monitoring
```
- **Prometheus UI**:
```bash
kubectl port-forward service/prometheus-operated -n monitoring 9090:9090
```

**NOTE:** If you are using an EC2 Instance or Cloud VM, you need to pass `--address 0.0.0.0` to the above command. Then you can access the UI on <instance-ip:port>

- **Grafana UI**: password is `prom-operator`
```bash
kubectl port-forward service/monitoring-grafana -n monitoring 8080:80
```
- **Alertmanager UI**:
```bash
kubectl port-forward service/alertmanager-operated -n monitoring 9093:9093
```

### 🧼 Step 5: Clean UP
- **Uninstall helm chart**:
```bash
helm uninstall monitoring --namespace monitoring
```
- **Delete namespace**:
```bash
kubectl delete ns monitoring
```
- **Delete Cluster & everything else**:
```bash
eksctl delete cluster --name observability
```
Perfect, Daksh 👍. Let’s ground Prometheus in **real-world Kubernetes use cases** so you can see how it’s actually used in production.  

---

## 🔥 Real-World Examples of Prometheus in Action

### 1. **Pod Crash Detection**
- **Scenario**: A backend pod keeps going into `CrashLoopBackOff`.  
- **Prometheus Metric**: `kube_pod_container_status_restarts_total`  
- **Use**: You set an alert if restarts > 5 in 10 minutes.  
- **Outcome**: Ops team gets notified before users even notice downtime.

---

### 2. **High CPU Usage on Node**
- **Scenario**: One Kubernetes node is overloaded, causing pods to be evicted.  
- **Prometheus Metric**: `node_cpu_seconds_total`  
- **Use**: Alert when CPU > 90% for 5 minutes.  
- **Outcome**: You scale the cluster or reschedule pods before the node crashes.

---

### 3. **Service Latency Monitoring**
- **Scenario**: Your API is slow, users complain.  
- **Prometheus Metric**: `http_request_duration_seconds_bucket`  
- **Use**: Track 95th percentile latency.  
- **Outcome**: You find that DB queries are the bottleneck → fix indexing.

---

### 4. **Autoscaling with HPA**
- **Scenario**: Traffic spikes during Diwali sale.  
- **Prometheus Metric**: `cpu_usage` or custom `requests_per_second`.  
- **Use**: HPA scales pods automatically when load increases.  
- **Outcome**: No downtime, smooth user experience.

---

### 5. **Database Connection Leaks**
- **Scenario**: Java backend (Hibernate) keeps exhausting DB connections.  
- **Prometheus Metric**: `db_connection_pool_active_connections`  
- **Use**: Alert when active connections > 90% of pool size.  
- **Outcome**: You catch the leak early and restart service before DB crashes.

---

### 6. **Network Traffic Tracing**
- **Scenario**: Some requests never reach your pod.  
- **Prometheus Metric**: `container_network_receive_bytes_total`  
- **Use**: Compare traffic at Service vs Pod level.  
- **Outcome**: You discover misconfigured labels in Service selector.

---

## 🪄 Analogy (Easy Hindi Version)

सोचो Prometheus एक **डॉक्टर** है जो हर मरीज (Pod/Node) का **ब्लड प्रेशर, हार्टबीट, शुगर लेवल** रोज़ चेक करता है।  
- अगर BP बहुत बढ़ गया → अलार्म बजा देता है (Alertmanager)।  
- अगर हार्टबीट स्लो है → तुरंत रिपोर्ट करता है (Grafana dashboard)।  
- इससे आप बीमारी (bug/issue) को **पहले पकड़ लेते हो**, मरीज ICU में जाने से पहले।  

---

👉 Daksh, since you like **dry-run traces**, I can show you a **real scrape flow example**:  
Prometheus scraping a Kubernetes Service → Pod `/metrics` → storing → alert firing.  

Yes, Daksh 👍 — you can absolutely build a **Prometheus + Grafana monitoring stack for free** to learn and even run small projects. Let me show you how people usually do it without spending money:

---

## 🆓 Free Ways to Set Up Prometheus Monitoring

### 1. **Local Kubernetes (Minikube / Kind)**
- Run a small cluster on your laptop.
- Deploy Prometheus + Grafana using **Helm charts** or **YAML manifests**.
- Cost: **₹0** (just your laptop resources).

```bash
# Example: install Prometheus + Grafana via Helm
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install my-prom prometheus-community/kube-prometheus-stack
```

---

### 2. **Docker Compose**
- If you don’t want Kubernetes overhead, run Prometheus + Grafana in Docker containers.
- Great for learning PromQL and dashboards.
- Cost: **Free**.

```yaml
# docker-compose.yml
version: '3'
services:
  prometheus:
    image: prom/prometheus
    ports:
      - "9090:9090"
  grafana:
    image: grafana/grafana
    ports:
      - "3000:3000"
```

---

### 3. **Free Cloud Tiers**
- Some cloud providers give **free credits** or **always-free tiers**:
  - Google Cloud (GKE free tier for small clusters).
  - AWS (EKS free for 12 months with free credits).
  - Azure (AKS free tier).
- You can deploy Prometheus + Grafana here, but watch out for hidden costs (storage, load balancers).

---

### 4. **Open-Source Exporters**
- All exporters (Node Exporter, cAdvisor, Blackbox Exporter) are **open-source and free**.
- You can monitor nodes, pods, and apps without paying.

---

### 5. **Grafana Cloud Free Plan**
- Grafana offers a **free hosted plan** with limited metrics/logs.
- Good if you don’t want to manage storage yourself.

---

## ⚡ Realistic Path for You
Since you like **hands-on debugging and dry-run tracing**, the best free setup is:
1. **Minikube** → run a small cluster locally.  
2. **Helm install kube-prometheus-stack** → deploy Prometheus + Grafana.  
3. Expose Grafana via NodePort → open dashboards in browser.  
4. Add exporters (Node Exporter, cAdvisor) → start seeing real metrics.  

---

## 🪄 Analogy
सोचो ये सब एक **फ्री जिम** जैसा है:  
- Prometheus = ट्रेनर (metrics collect करता है)  
- Grafana = शीशा (dashboard में progress दिखाता है)  
- Exporters = मशीनें (data निकालते हैं)  
- Minikube = घर का छोटा gym setup (free, बस बिजली और laptop चाहिए)  

---

👉 Daksh, do you want me to **write a step-by-step YAML + commands demo** for setting up Prometheus + Grafana on **Minikube** (your laptop) so you can actually see metrics flowing in real time?
















