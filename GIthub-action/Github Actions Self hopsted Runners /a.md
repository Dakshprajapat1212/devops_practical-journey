From [09:00](#timestamp-00:09:00) to [11:00](#timestamp-00:11:00), here’s exactly what Abhishek says in his own words:

> “Okay so now my EC2 instance is getting launched. I did not use any additional configuration till now but after this I am going to configure the inbound and outbound traffic rules which are very important. So the instance is getting started. Once the instance is started what I’ll do is I’ll move to the security tab and I’ll modify the inbound and outbound traffic rules. Open the HTTPS HTTP port both—only the HTTP and HTTPS port for the inbound and outbound, nothing more than that. Because your AWS account and GitHub account both of them can be or cannot be in the same network. You know sometimes you might be using a public hosted GitHub account whereas your AWS might be within a VPC. Or other way around—your AWS you might have in public EC2 instance but your GitHub it can be an enterprise GitHub which is sitting inside your office network. So there can be any reason and you have to be very very careful in opening the ports. If you misconfigure the ports then there is a very good—how do I say that—yeah, there is a very good chance of you running into some security concerns. So that’s why make sure you open the right inbound and outbound traffic rules. So go to the security groups like I told you, only open port 80 and port 443 which is HTTP and HTTPS ports in both the inbound and outbound traffic rules.”

Let me know if you want the next part too, or a Hindi translation.

Absolutely! Let’s break this down step by step in **very simple language**, with **real-world examples**, so you understand exactly what Abhishek is saying between [09:00–11:00](#timestamp-00:09:00) in the video.

---

## 🧠 What Is He Talking About?

He’s explaining how to **configure network access** for your **AWS EC2 instance** that will act as a **GitHub Actions self-hosted runner**.

This means:  
You’re setting up a machine (EC2) that GitHub will send jobs to. For this to work, GitHub and your EC2 must be able to **talk to each other over the internet**.

---

## 🔐 What Are Inbound and Outbound Rules?

These are **firewall settings** in AWS called **Security Groups**. They control:

- **Inbound**: What traffic is allowed **into** your EC2 instance.
- **Outbound**: What traffic is allowed **out from** your EC2 instance.

Think of it like:
- Inbound = Who can knock on your door.
- Outbound = Where you’re allowed to go.

---

## 🌐 Why Open Only Port 80 and 443?

These are **standard internet ports**:

| Port | Protocol | Purpose               |
|------|----------|------------------------|
| 80   | HTTP     | Normal web traffic     |
| 443  | HTTPS    | Secure web traffic     |

GitHub communicates with your EC2 runner using **HTTPS (443)**. Sometimes it may use **HTTP (80)** for fallback or metadata.

So you need to **allow these ports** in both directions:
- **Inbound**: GitHub sends job instructions to EC2.
- **Outbound**: EC2 sends job results back to GitHub.

---

## 🧱 Example: Security Group Setup

Let’s say you launched an EC2 instance named `github-runner`.

### ✅ Inbound Rules
| Type   | Protocol | Port Range | Source         |
|--------|----------|------------|----------------|
| HTTP   | TCP      | 80         | Anywhere (0.0.0.0/0) |
| HTTPS  | TCP      | 443        | Anywhere (0.0.0.0/0) |

### ✅ Outbound Rules
| Type   | Protocol | Port Range | Destination    |
|--------|----------|------------|----------------|
| HTTP   | TCP      | 80         | Anywhere (0.0.0.0/0) |
| HTTPS  | TCP      | 443        | Anywhere (0.0.0.0/0) |

> ⚠️ **Do NOT use “All Traffic”** — it’s tempting but dangerous. It allows everything, including insecure or unnecessary ports, which hackers can exploit.

---

## 🧠 Why Is This Important?

Abhishek explains that **GitHub and AWS may not be in the same network**:

### Scenario 1:
- GitHub = Public (hosted on internet)
- AWS EC2 = Inside a **private VPC** (Virtual Private Cloud)

### Scenario 2:
- GitHub = Enterprise version (inside your company network)
- AWS EC2 = Public instance

In both cases, **network communication can break** if ports are blocked. That’s why you must **explicitly allow 80 and 443**, so GitHub and EC2 can talk.

---

## 🧪 What Happens If You Misconfigure?

- GitHub won’t be able to send jobs to your EC2 runner.
- EC2 won’t be able to send back job results.
- Your GitHub Actions workflow will **fail silently** or hang.
- You might expose your EC2 to **security risks** if you open unnecessary ports.

---

## ✅ Summary

| Step | What to Do | Why |
|------|------------|-----|
| 1️⃣   | Open port 80 and 443 in **Inbound** | So GitHub can send jobs to EC2 |
| 2️⃣   | Open port 80 and 443 in **Outbound** | So EC2 can send results back to GitHub |
| 3️⃣   | Avoid “All Traffic” | Prevent security vulnerabilities |
| 4️⃣   | Use “Anywhere” or restrict to GitHub IPs | Depends on your network setup |

---

In tech terms, **“same network”** means that two systems—like your AWS EC2 instance and your GitHub runner—are part of a **shared network environment** where they can communicate directly without needing to go through the public internet.

---

## 🧩 What “Same Network” Means

Here’s how it breaks down:

### 🔗 **Same Network**
- Both systems are in the **same Virtual Private Cloud (VPC)** or subnet.
- They can **ping** each other or exchange data using **private IP addresses**.
- No need for public IPs, NAT gateways, or VPNs.
- Example: Your GitHub self-hosted runner is on an EC2 instance, and your application server is on another EC2 instance in the same VPC. They can talk directly.

### 🌐 **Different Networks**
- Systems are in **separate VPCs**, regions, or even different platforms (like GitHub and AWS).
- You need **internet access**, **VPN**, or **VPC peering** to connect them.
- Example: GitHub (hosted on GitHub’s infrastructure) needs to trigger a runner on your EC2 instance. If the EC2 is in a private subnet, you’ll need a NAT gateway or some bridge to allow communication.

---

## 🛠️ Why It Matters

- **Security**: Keeping systems in the same private network reduces exposure to the internet.
- **Latency**: Communication is faster within the same network.
- **Cost**: Data transfer within the same network is often cheaper than across public networks.

# “Same Network” vs “Different Network” Explained with Real-World Examples

Jab hum kehte hain “GitHub runner aur EC2 ek hi VPC/subnet mein hain,” iska matlab hai ki dono systems **private IPs** se, **bina public Internet ke**, seedha baat kar sakte hain. Chaliye do alag scenarios lete hain:

---

## 1. Different Networks  
**(Default GitHub.com + EC2 Setup)**

- **GitHub Actions**  
  • Hosted on GitHub’s own servers, jo public Internet pe accessible hain.  
  • Aapke runner ko job assign karne ke liye GitHub APIs ko Internet ke through hit karta hai.

- **Your EC2 Runner**  
  • AWS VPC mein, private subnet ya public subnet—jo bhi aapne choose kiya hai.  
  • Agar private subnet hai → outbound Internet ke liye NAT Gateway ki zaroorat.  
  • Agar public subnet hai → direct public IP ke through Internet.

- **Communication Flow**  
  1. Runner (EC2) **outbound** HTTPS request bhejta hai GitHub.com API pe.  
  2. GitHub API response bhejta hai runner ke liye jobs.  
  3. Saari traffic public Internet routes (NAT/IP Gateway) se guzarti hai.  

- **Use Case**  
  - Open-source ya small teams jo public Internet pe build runners chalana chahte hain.  
  - Jaldi setup, kam configuration—lekin Internet-exposed.

---

## 2. Same Network  
**(GitHub Enterprise Server / PrivateLink Setup)**

### A. GitHub Enterprise Server on AWS  
- Aapka company GitHub Enterprise Server ko apni AWS VPC mein deploy karta hai.  
- Saath hi, self-hosted runner bhi **same VPC** aur **same subnet** mein chal raha hai.  
- **Private IPs** se communication hoti hai—koi public Internet ya NAT Gateway ki zaroorat nahi.

#### Flow  
1. Enterprise GitHub Server private IP pe jobs queue karta hai.  
2. Runner private IP se jobs pull karta hai.  
3. Results wapas private network se hi GitHub Server mein store ho jaate hain.

#### Kab Use Kare?  
- Compliance/regulatory requirements (e.g., finance, healthcare) jahan data Internet pe nahi jaana.  
- Ultra-low latency chahiye—sub-millisecond response within VPC.  
- Network ingress/egress audit karna ho.

### B. GitHub.com + AWS PrivateLink (GitHub Connect)  
- GitHub ne AWS PrivateLink endpoints provide kiye hain.  
- Aap **VPC Endpoint** create karte ho (interface endpoint) for GitHub Actions.  
- EC2 runner VPC ke andar hi, **private link** se GitHub.com APIs ko access karta hai—public Internet block karke.

#### Flow  
1. Runner se call jati hai VPC Endpoint pe.  
2. AWS backbone network ke through GitHub.com tak request jati hai.  
3. Response vapas aata hai same private link se.

#### Kab Use Kare?  
- Jab GitHub.com hi use karna hai, but public Internet se bachna hai.  
- Security posture tight karna ho—only specific VPC endpoints allow hone chahiye.  
- Data transfer cost/Azure egress kam karni ho.

---

## Key Benefits & Trade-Offs

| Aspect         | Different Network                       | Same Network                                 |
|----------------|-----------------------------------------|-----------------------------------------------|
| Connectivity   | Internet / NAT / Security Groups        | Private IP / VPC Endpoint                     |
| Security       | Public-facing, more exposure            | Fully private, minimal exposure               |
| Latency        | Internet latency                        | Sub-ms internal VPC latency                   |
| Cost           | NAT/Egress charges                      | Internal data-transfer, PrivateLink charges   |
| Setup Effort   | Very simple                             | Extra AWS infra (VPC, PrivateLink, Enterprise)|

---

**Summary:**  
- **Default** GitHub.com runner + EC2 → **Different Networks** (Internet-based).  
- **GitHub Enterprise** or **PrivateLink** → **Same Network** (private, direct).

Batao, kis setup pe detail chahiye—Configuration steps, IAM policies, ya AWS Console walkthrough? 😄


