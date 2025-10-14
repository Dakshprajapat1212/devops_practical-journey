╰─$ helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

"prometheus-community" has been added to your repositories
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "prometheus-community" chart repository
Update Complete. ⎈Happy Helming!⎈
╭─dakash@dakshs-MacBoo╭─dakash@dakshs-Ma╭─╭─╭─╭─╭─dakash@dakshs-MacBook-Air-2 ~ ‹m╭─╭─dakash@dakshs-MacBook-Air-2 ~ ‹main●›╭─dakash@dakshs-MacBook-Air-2 ~ ‹main╭─dakash@dakshs-MacBook-Air-2 ~ ‹main●› 
╰─$ helm install my-prometheus prometheus-community/prometheus      
I1014 17:45:48.244551    9573 warnings.go:110] "Warning: spec.SessionAffinity is ignored for headless services"
NAME: my-prometheus
LAST DEPLOYED: Tue Oct 14 17:45:47 2025
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
The Prometheus server can be accessed via port 80 on the following DNS name from within your cluster:
my-prometheus-server.default.svc.cluster.local


Get the Prometheus server URL by running these commands in the same shell:
  export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=prometheus,app.kubernetes.io/instance=my-prometheus" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace default port-forward $POD_NAME 9090


The Prometheus alertmanager can be accessed via port 9093 on the following DNS name from within your cluster:
my-prometheus-alertmanager.default.svc.cluster.local


Get the Alertmanager URL by running these commands in the same shell:
  export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=alertmanager,app.kubernetes.io/instance=my-prometheus" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace default port-forward $POD_NAME 9093
#################################################################################
######   WARNING: Pod Security Policy has been disabled by default since    #####
######            it deprecated after k8s 1.25+. use                        #####
######            (index .Values "prometheus-node-exporter" "rbac"          #####
###### .          "pspEnabled") with (index .Values                         #####
######            "prometheus-node-exporter" "rbac" "pspAnnotations")       #####
######            in case you still need it.                                #####
#################################################################################


The Prometheus PushGateway can be accessed via port 9091 on the following DNS name from within your cluster:
my-prometheus-prometheus-pushgateway.default.svc.cluster.local


Get the PushGateway URL by running these commands in the same shell:
  export POD_NAME=$(kubectl get pods --namespace default -l "app=prometheus-pushgateway,component=pushgateway" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace default port-forward $POD_NAME 9091

For more information on running Prometheus, visit:
https://prometheus.io/



─$ kubectl get pods
NAME                                                    READY   STATUS    RESTARTS      AGE
my-prometheus-alertmanager-0                            1/1     Running   0             39m
my-prometheus-kube-state-metrics-5c4c778cc9-pl4qc       1/1     Running   0             39m
my-prometheus-prometheus-node-exporter-rl9j7            1/1     Running   0             39m
my-prometheus-prometheus-pushgateway-7fdf4bf646-hqmnb   1/1     Running   0             39m
my-prometheus-server-7477987ff6-xzj7p                   2/2     Running   0             39m
sample-python-app-6fb94b7f58-xqc9p                      1/1     Running   1 (99m ago)   4d21h
╭─dakash@dakshs-MacBook-Air-2 ~ ‹main●› 
╰─$ my-prometheus-alertmanager.default.svc.cluster.local
╭─dakash@dakshs-MacBook-Air-2 ~ ‹main●› 
╰─$ kubectl get svc                     1 ↵
NAME                                     TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
kubernetes                               ClusterIP   10.96.0.1        <none>        443/TCP        9d
my-prometheus-alertmanager               ClusterIP   10.99.88.86      <none>        9093/TCP       100m
my-prometheus-alertmanager-headless      ClusterIP   None             <none>        9093/TCP       100m
my-prometheus-kube-state-metrics         ClusterIP   10.96.204.224    <none>        8080/TCP       100m
my-prometheus-prometheus-node-exporter   ClusterIP   10.107.166.207   <none>        9100/TCP       100m
my-prometheus-prometheus-pushgateway     ClusterIP   10.108.69.73     <none>        9091/TCP       100m
my-prometheus-server                     ClusterIP   10.98.80.166     <none>        80/TCP         100m
python-django-sample-app                 NodePort    10.106.104.244   <none>        80:30007/TCP   9d



Got it Daksh 👍 — you want the **`kubectl expose` command** that makes a Service of type **NodePort**, so you can access something like Prometheus or Grafana from outside the cluster.  

Here’s the exact command pattern:

---

## ✅ Expose a Deployment/Pod as NodePort
```bash
kubectl expose deployment my-prometheus-server \
  --type=NodePort \
  --name=my-prometheus-service \
  --port=9090 \
  --target-port=9090
```

### 🔎 Breakdown
- **`kubectl expose`** → creates a Service object.  
- **`deployment my-prometheus-server`** → the resource you’re exposing (could be a pod, deployment, or replicaset).  
- **`--type=NodePort`** → makes it accessible on a port of the node (outside the cluster).  
- **`--name=my-prometheus-service`** → name of the Service created.  
- **`--port=9090`** → the port the Service will expose.  
- **`--target-port=9090`** → the container port inside the pod.  

---

## ✅ Example for Grafana
```bash
kubectl expose deployment my-prometheus-grafana \
  --type=NodePort \
  --name=grafana-nodeport \
  --port=3000 \
  --target-port=3000
```

---

## 🔍 Verify
```bash
kubectl get svc
```
You’ll see something like:
```
NAME                   TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
grafana-nodeport       NodePort   10.96.123.45   <none>        3000:32000/TCP   1m
```

👉 Here, `32000` is the **NodePort** assigned.  
Now you can open Grafana in browser at:  
```
http://<NodeIP>:32000
```

---

🪄 **Analogy (Hindi)**  
सोचो Pod = घर के अंदर TV,  
Service (NodePort) = घर के बाहर लगा **doorbell switch**।  
अब कोई भी बाहर से उस switch (NodePort) को दबाकर अंदर वाले TV (Pod) तक पहुँच सकता है।  

---


<img width="1470" height="956" alt="Screenshot 2025-10-14 at 7 46 27 PM" src="https://github.com/user-attachments/assets/7d0a3b3d-4df1-4272-aecb-1d3425c74f58" />




