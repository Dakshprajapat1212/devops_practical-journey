Absolutely Daksh! Here's a comprehensive cheat sheet of essential **Kubernetes (kubectl)** commands, organized by category for quick reference. This will be super handy for your deployments, debugging, and interview prep.

---

## 🧭 Cluster & Node Management

| Command | Description |
|--------|-------------|
| `kubectl cluster-info` | Show cluster info |
| `kubectl get nodes` | List all nodes |
| `kubectl describe node <node-name>` | Detailed node info |
| `kubectl cordon <node>` | Mark node unschedulable |
| `kubectl drain <node>` | Safely evict pods for maintenance |
| `kubectl uncordon <node>` | Make node schedulable again |

---

## 📦 Pod & Deployment Management

| Command | Description |
|--------|-------------|
| `kubectl get pods` | List pods in current namespace |
| `kubectl get pods -A` | List pods in all namespaces |
| `kubectl describe pod <pod-name>` | Pod details |
| `kubectl logs <pod-name>` | View logs |
| `kubectl exec -it <pod-name> -- bash` | Access pod shell |
| `kubectl apply -f <file.yaml>` | Create/update resource from YAML |
| `kubectl delete -f <file.yaml>` | Delete resource from YAML |
| `kubectl rollout restart deployment <name>` | Restart deployment |
| `kubectl scale deployment <name> --replicas=3` | Scale pods |
| `kubectl rollout status deployment <name>` | Check rollout status |

---

## 🧱 ReplicaSets, Services & Networking

| Command | Description |
|--------|-------------|
| `kubectl get rs` | List ReplicaSets |
| `kubectl get svc` | List services |
| `kubectl expose deployment <name> --type=NodePort --port=80` | Create service |
| `kubectl port-forward svc/<service-name> 8080:80` | Forward local port to service |
| `kubectl get endpoints` | Show service endpoints |

---

## 🧾 ConfigMaps & Secrets

| Command | Description |
|--------|-------------|
| `kubectl create configmap <name> --from-literal=key=value` | Create ConfigMap |
| `kubectl get configmaps` | List ConfigMaps |
| `kubectl create secret generic <name> --from-literal=key=value` | Create Secret |
| `kubectl get secrets` | List Secrets |

---

## 🧪 Debugging & Monitoring

| Command | Description |
|--------|-------------|
| `kubectl top pod` | Show pod resource usage |
| `kubectl top node` | Show node resource usage |
| `kubectl get events` | View cluster events |
| `kubectl describe <resource> <name>` | Detailed resource info |
| `kubectl get all` | List all resources in current namespace |
| `kubectl get all -A` | List all resources across namespaces |

---

## 🧰 Miscellaneous

| Command | Description |
|--------|-------------|
| `kubectl version` | Show client/server version |
| `kubectl config view` | View kubeconfig |
| `kubectl config current-context` | Show current context |
| `kubectl config use-context <name>` | Switch context |
| `kubectl get namespaces` | List namespaces |
| `kubectl create namespace <name>` | Create namespace |

---

Want me to convert this into a printable Hindi cheat sheet or diagram-style note for your knowledge base? I can also add real-world CLI examples from your deployments. Just say the word.
