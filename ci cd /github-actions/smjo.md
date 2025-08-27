step/1

name: My First GitHub Actions

on: 
   push:
       branches:
         - main #change 
      

jobs:
  build:
    runs-on: self-hosted

    strategy:
      matrix:
        python-version: [3.8, 3.9]

    steps:
    - uses: actions/checkout@v3
    - name: Set up Python
      uses: actions/setup-python@v2
      with:
        python-version: ${{ matrix.python-version }}

    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install pytest

    - name: Run tests
      run: |
        cd src
        python -m pytest addition.py


irrrespective what action does in github , any chnages   , if on

then github start action file



there is no limititaion , in .github/workflow   we can use any number of action file 

action file is a pipline  like used in jenkins pipline''

we use nomber of file 

like one file ensure  if users provifdde proper description in pull rewuest


in other pipline ensure foramtting and linking  issue

other filr used for ci 

other pipline can be used fr cd



<img width="1470" height="956" alt="Screenshot 2025-08-28 at 12 38 14 AM" src="https://github.com/user-attachments/assets/928de70c-2756-4b89-8ebe-df71a1b86fc6" /> 
shows argo cd repo uses multi fileds


 
we can desfine action one or more 
In both **GitHub Actions** and **Jenkins**, the term “action” refers to a **triggered task or job** that runs in response to an event — like a code push, pull request, or scheduled build. But the way you define and manage these actions differs between the two platforms.

---

## ⚙️ GitHub Actions — Types of Actions You Can Define

GitHub Actions uses **YAML files** inside `.github/workflows/` to define automation. You can trigger actions based on:

### 🔹 Common Triggers
- `on: push` → Run when code is pushed
- `on: pull_request` → Run when a PR is opened or updated
- `on: issue` → Run when an issue is created or modified
- `on: schedule` → Run on a cron-like schedule
- `on: workflow_dispatch` → Manual trigger via UI

### 🔹 Typical Actions
- **CI**: Build and test code
- **CD**: Deploy to staging or production
- **Linting**: Check code formatting
- **Security**: Scan for vulnerabilities
- **Release**: Tag and publish new versions
- **PR Checks**: Validate pull request titles or descriptions

You can define multiple workflows for different purposes — like `ci.yml`, `deploy.yml`, `release.yml`.

---

## 🛠 Jenkins — Types of Actions You Can Define

Jenkins uses **Pipeline scripts (usually Groovy)** or UI-based jobs to define actions. You can trigger builds based on:

### 🔹 Common Triggers
- SCM polling (e.g., Git push)
- Webhooks
- Scheduled builds (`cron`)
- Manual trigger via UI
- Upstream/downstream job completion

### 🔹 Typical Actions
- **Build**: Compile code using Maven, Gradle, etc.
- **Test**: Run unit or integration tests
- **Deploy**: Push artifacts to servers or Kubernetes
- **Static Analysis**: Run SonarQube or Checkstyle
- **Artifact Management**: Upload to Nexus or Artifactory
- **Notification**: Send Slack or email alerts

Jenkins pipelines are more customizable but require more setup — like installing plugins and managing agents.

---

## 🔄 Summary Table

| Feature              | GitHub Actions                          | Jenkins                                 |
|----------------------|------------------------------------------|------------------------------------------|
| **Trigger Types**    | Push, PR, Issue, Schedule, Manual        | SCM, Cron, Webhook, Manual, Job chaining |
| **Definition Format**| YAML (`.github/workflows`)              | Groovy (Jenkinsfile) or UI               |
| **Plugin Setup**     | Auto-installed via Marketplace           | Manual installation                      |
| **Ease of Use**      | Simple, GitHub-native                    | Powerful but more complex                |
| **Best For**         | GitHub-based projects                    | Enterprise-scale CI/CD                   |

---

In the video you're watching, the instructor shows how to define multiple GitHub Actions for different tasks — like CI builds, PR checks, and deployments — and compares them to Jenkins pipelines.

Want me to help you write a sample GitHub Actions workflow or Jenkinsfile for your own project? I can tailor it to whatever tech stack you're using.















        
