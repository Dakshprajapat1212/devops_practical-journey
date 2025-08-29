# Jenkins Master-Agent Ka Practical Workflow

---

## 1. Teams Ka Jenkins Master Se Connection

Har team ka code Jenkins master se **webhook** aur **SCM polling** ke zariye connect hota hai:

- GitHub/GitLab/Webhook setup  
  - Jab bhi code push hota hai, webhook Jenkins master ke endpoint (`http://jenkins.example.com/github-webhook/`) ko HTTP POST request bhejta hai.  
- Jenkins Master SCM Polling  
  - Agar webhook nahin hai, toh master har kuch minutes mei repository check karta hai ki koi commit aya ya nahi.  
- Credentials & Access  
  - Master ke paas Git credentials (SSH key ya token) configured hote hain, jisse woh private repos se code checkout kar sakta hai.

---

## 2. Master Server Ka Uptime

Jenkins master ko **24/7** chalana zaroori hota hai:

- Master hi UI host karta hai, jobs schedule karta hai, agents ko instructions deta hai.  
- Agar master down hua, toh pipeline triggers, build history aur dashboards inaccessible ho jayenge.  
- Production-grade setups mei master ko HA (High Availability) mode mei cluster ki tarah deploy bhi karte hain.

---

## 3. Code Change Trigger Par Node Assignment

Jab master ko webhook ya polling se change trigger milta hai:

1. **Job Definition (Pipeline)**  
   - Jenkinsfile mein stages define hoti hain: Build, Test, Deploy.  
2. **Node Selection**  
   - `agent { label 'linux && docker' }` ya `agent any` ki setting se master decide karta hai kaunsa agent allocate hoga.  
3. **Queue Aur Dispatch**  
   - Master pehle se available idle nodes ki list dekhta hai, phir suitable node ko job assign karta hai.  
4. **Execution**  
   - Assigned node master se step-by-step instructions leke code build/test/deploy karta hai.

---

## 4. Nodes (Agents) Ka Configuration Aur Labels

Agents ko labels se tag kiya jata hai taaki specific environments use ho sake:

| Agent Type     | Label           | Use Case                         |
| -------------- | --------------- | -------------------------------- |
| Static Agent   | `linux`, `arm`  | On-prem servers, dedicated VMs   |
| Dynamic Agent  | `docker`, `aws` | Cloud containers, ephemeral pods |

- **Static Agents**  
  - Jenkins master ki UI → Manage Nodes → New Node → SSH credentials → Label assign.  
- **Dynamic Agents**  
  - Cloud plugins (Kubernetes, AWS EC2) se auto-provisioning  
  - Label-based provisioning rules define karke, master agent pool se pod ya VM spin-up karwata hai.

---

## 5. Pipeline Instructions Ki Location

Sari build/test/deploy instructions **code repository** mei hi stored hoti hain:

- `Jenkinsfile` (root of repo)  
- Declarative ya scripted pipeline syntax  
- Version-controlled: har branch/apk version ke saath Jenkinsfile bhi track hota hai.

---

## 6. Agent Lifecycle: Spin-Up Se Shutdown Tak

1. **Provisioning**  
   - Webhook trigger → master checks node availability → plugin ke through new agent launch  
2. **Registration**  
   - Agent Jenkins master se connect hokar apna fingerprint exchange karta hai  
3. **Job Execution**  
   - Code checkout → build/test → artifacts publish  
4. **Cleanup**  
   - Workspace wipeout → container/VM shutdown (agar dynamic ho)  
5. **Deregistration**  
   - Agent master se disconnect → next trigger tak idle pool se remove

---

## 7. Deployment Kaise Hota Hai

Deployment stages Jenkinsfile mei define hote hain:

```groovy
pipeline {
  agent { label 'deploy-node' }
  stages {
    stage('Deploy') {
      steps {
        sshagent(credentials: ['prod-ssh-key']) {
          sh 'ssh user@prod-server "cd /app && git pull && systemctl restart app"'
        }
      }
    }
  }
}
```

- `sshagent` plugin se SSH credentials inject  
- Remote server pe commands run karke application restart  

---

### Aage Ki Soch

Agar tumhara environment bahut dynamic hai, toh:

- **Kubernetes Plugin** se pods mei build-run-deploy kar sakte ho  
- **Pipeline Libraries** banake common steps share kar sakte ho  
- **Multibranch Pipelines** se har branch ka alag Jenkinsfile automatically detect hota hai  

In pointers ko explore karke apna Jenkins setup aur agile, scalable bana sakte ho.

# एक ही Jenkins Master से Multiple Organizations को कैसे जोड़ते हैं?

जब भी कोड किसी भी रिपो में पुश होता है, वो HTTP POST के ज़रिए Jenkins Master को नोटिफाई कर देता है। लेकिन सवाल ये है कि अलग-अलग GitHub/GitLab Organizations का कोड एक ही Master से कैसे कनेक्ट होता है, और क्या ये Master हमेशा ऑन रहना चाहिए? चलिए स्टेप बाई स्टेप देखते हैं:

---

## 1. Jenkins Master का एक पब्लिक एंडपॉइंट बनाना

- Jenkins Master को एक स्थिर DNS (जैसे `jenkins.company.com`) या आईपी के साथ पब्लिकली एक्सपोज़ करें।  
- ऊपर वाला URL सभी Organizations में वेबहुक्स के Payload URL के रूप में यूज़ होगा (उदा. `http://jenkins.company.com/github-webhook/`).  
- सुरक्षा के लिए SSL/TLS (HTTPS) लागू करें और केवल ज़रूरी HTTP मेथड (POST) खोलें।

---

## 2. Webhook Configuration for Each Organization

हर Organization या Repository में आपको webhook इस तरह से सेटअप करना होता है:

1. Organization/Repo Settings → Webhooks → Add webhook  
2. Payload URL:  
   ```
   http://jenkins.company.com/github-webhook/
   ```  
3. Content Type: `application/json`  
4. Secret (optional): एक पासफ्रेज़ जो Jenkins Master में भी कॉन्फ़िगर होगा  
5. Events:  
   - Push events  
   - Pull request events (अगर आप PR बिल्ड चाहते हैं)  

अब, चाहे आपका कोड Org-A में हो या Org-B में, सभी वेबहुक्स एक ही Master को HTTP POST भेजेंगे।

---

## 3. Jenkins Credentials & Job Configuration

- **Credentials Store** में हर Org के लिए GitHub App Token या Personal Access Token जोड़ें।  
- **Multibranch Pipeline Job** या **GitHub Organization Job** बनाएं जो उस Organization को स्कैन करे:  
  - SCM: GitHub  
  - Credentials: आपने जो Token जोड़ा  
  - Repository owner: eg. `Org-A` या `Org-B`  
- Jenkinsfile हर रिपो के रूट में होना चाहिए — यही बिल्ड/टेस्ट/डिप्लॉय स्टेप्स बताएगा।

---

## 4. GitHub Organization Plugin (Optional)

अगर बहुत सारी रिपो हैं, तो हर एक के लिए अलग-अलग जॉब बनाना मुश्किल होगा। तब आप:

- **GitHub Organization Plugin** इंस्टॉल करें  
- Jenkins Global Configuration → GitHub Organizations → New Organization  
  - Organization नाम  
  - Credentials  
  - Scan credentials  
- Jenkins इस Org के सभी रिपो को ऑटोमैटिकली स्कैन करेगा, हर एक में Jenkinsfile देख कर जॉब क्रिएट करेगा, और वेबहुक भी सेट करेगा।

---

## 5. Master का Uptime और High Availability

- Master **24×7** ऑन रहना चाहिए, क्योंकि  
  - UI एक्सेस करने के लिए  
  - वेबहुक रिसीव करने के लिए  
  - जॉब्स शेड्यूल करने के लिए  
- **अगर Master डाउन हुआ**, तो कोई ट्रिगर या बिल्ड रन नहीं होगा।  
- Production में अक्सर  
  - **Backup Masters** या  
  - **Active-Passive Master Cluster** या  
  - **Kubernetes Operator** के ज़रिये HA सेटअप  
  का इस्तेमाल होता है।

---

## 6. पूरा Flow (ASCII Diagram)

```
[Developer Push] 
      ↓  
[GitHub Org-A Repo] 
      ↓ (Webhook POST)
[Jenkins Master] 
      ↓ (जॉब डिस्पैच)
[Agent Node 1] — build/test  
[Agent Node 2] — deploy  
```

- सभी Orgs के वेबहुक इसी Master पर आते हैं।
- Master Idle Agents की लिस्ट देख कर उपयुक्त Agent (Node) को बिल्ड या डिप्लॉय देता है।

---

### आगे क्या देख सकते हैं?

- Jenkins Master को **Kubernetes** पर रन कर के Self-Healing और Auto-Scaling  
- **GitLab CI** या **Bitbucket Pipelines** के साथ समान संरचना समझना  
- Master-Agent सिक्योरिटी: **Mutual TLS**, **Vault-based Credentials**  

इन स्टेप्स को फॉलो करके आप एक ही Jenkins Master से कई Organizations को आराम से मैनेज कर पाएंगे, और पक्का रहेगा कि Master हमेशा रिस्पॉन्सिबल और ऑन-लाइन हो।
