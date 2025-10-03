Kubeshark is like **Wireshark for Kubernetes**—but instead of sniffing packets on your laptop, it inspects **real-time API traffic** inside your Kubernetes cluster. Think of it as a **network observability tool** that lets you see how services, pods, and containers communicate, debug issues, and understand traffic flow at a granular level.

### 🧠 What Kubeshark Actually Does

- 📡 **Captures API calls** between Kubernetes components (e.g., `kubectl get pods` is actually a GET request to the API server).
- 🔍 **Monitors traffic** across containers, pods, nodes, and services.
- 🧵 **Visualizes request flows**—you can see how a user request travels through services and hits different pods.
- 🛠️ **Debugs issues** like service discovery failures, load balancing quirks, or unexpected traffic drops.
- 🔐 **Supports security auditing** by showing outbound/inbound traffic and potential anomalies.

### 🧪 Use Cases for You, Daksh

Since you're deep into DevOps and backend workflows, Kubeshark can help you:

- **Trace traffic** between microservices in real time.
- **Verify service selectors** and label-based routing.
- **Debug YAML misconfigurations** by watching how traffic fails to route.
- **Understand load balancing** behavior across replicas.
- **Capture traffic for replay or analysis** using tools like Wireshark or TCPDump.

### 🖥️ How to Use It

- Install via curl or Homebrew.
- Run `kubeshark tap -A` to monitor all namespaces.
- Access the dashboard at `localhost:8899` to view traffic flows visually.

Want a demo walkthrough or a cheat sheet for setup and use? I can whip one up in Hindi or diagram-style if you’d like.
