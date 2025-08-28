how to attach this self hosted runnerr with action 
and how they coommnubnicate
# GitHub Actions self‑hosted runner on AWS EC2: complete step‑by‑step

This is a practical, end‑to‑end guide that mirrors the workflow shown in the referenced video and expands it with production‑grade details, gotchas, and exact commands. You’ll set up an EC2 instance as a self‑hosted runner, wire it to a GitHub repository, switch a workflow from GitHub‑hosted to self‑hosted, and validate the job execution and networking. Where the video makes specific choices, those are noted and cited.

---

## Overview and prerequisites

- **Goal:** Configure a self‑hosted GitHub Actions runner on an EC2 Ubuntu instance, then run a Python CI workflow on it, switching from a GitHub‑hosted runner to a self‑hosted runner. 
- **Why self‑hosted:** For private repos, stronger security control, heavyweight compute needs, or custom dependencies not available on GitHub‑hosted images. 

#### Prerequisites

- **AWS account:** Ability to launch EC2 in your region.
- **GitHub repository:** You must be admin/maintainer to add runners.
- **SSH access:** A key pair to connect to the EC2 instance.
- **Security group control:** Permission to edit inbound/outbound rules.
- **Basic tools:** curl, tar, systemd or tmux/screen (optional for service mode).

> The video uses Ubuntu on EC2 and configures only HTTP/HTTPS ports on the security group, then registers and runs the runner interactively. 

---

## When to use self‑hosted vs GitHub‑hosted

- **Private repositories:** Use self‑hosted when code must stay within your controlled environment. 
- **Security posture:** Avoid opaque multi‑tenant runners if you need strict data handling guarantees. 
- **Resource needs:** Use custom machine sizes (e.g., high RAM/CPU/GPU) or preinstalled niche dependencies. 

> Direct answer: The video highlights private code, security, and custom resource/dependency needs as the three main drivers. 

---

## Provision the EC2 runner host

#### Launch EC2 instance

1. **Name:** “github-runner-ubuntu” or similar.   
2. **AMI:** Ubuntu LTS (e.g., 22.04).   
3. **Instance size:** Start with t3.small/t3.medium; pick larger if you need it (e.g., for tests).  
4. **Key pair:** Create/use an existing one to SSH in.   
5. **Network:** Default VPC/subnet is fine for public testing; in prod, place in a private subnet with an egress path (NAT).  
6. **Storage:** 20–50 GB gp3 for general use; more if you cache/build large artifacts.

> The video keeps defaults for simplicity and focuses on security group configuration. 

#### Configure security group

- **Inbound rules:**  
  - **HTTP (80):** Source “Anywhere-IPv4” or your GitHub Enterprise egress CIDRs if known.   
  - **HTTPS (443):** Same as above. 

- **Outbound rules:**  
  - **HTTP (80) + HTTPS (443):** Destination “Anywhere-IPv4” (or restrict to GitHub domains/IPs if you maintain allowlists). 

- **Do not use:**  
  - **All traffic:** Avoid broad rules; the video explicitly cautions against it to reduce security risk. 

- **Why both directions:**  
  - **Inbound:** Runner must receive job orchestration from GitHub.  
  - **Outbound:** Runner must send status and logs back to GitHub. 

> The video demonstrates adding only ports 80 and 443 in both inbound and outbound and explains why. 

---

## Install and register the GitHub Actions runner

#### Gather registration details

- **Repo path:** Go to your repository ➜ **Settings** ➜ **Actions** ➜ **Runners** ➜ **New self‑hosted runner**. 
- **Choose platform:** Linux, matching the EC2’s architecture (e.g., x64/AMD64 or ARM64). 
- **Copy commands:** GitHub shows exact download, configure, and run commands with a one‑time registration token. Keep the token secret. 

> The video pauses screen recording to avoid exposing the token and stresses secrecy. 

#### Connect to the instance and install

- **SSH in:**
  ```bash
  ssh -i /path/to/key.pem ubuntu@<EC2_PUBLIC_IP>
  ```

- **Create a directory and download the runner (example for x64):**
  ```bash
  mkdir -p actions-runner && cd actions-runner
  curl -o actions-runner-linux-x64.tar.gz -L https://github.com/actions/runner/releases/download/v<version>/actions-runner-linux-x64-<version>.tar.gz
  tar xzf actions-runner-linux-x64.tar.gz
  ```

- **Configure the runner (replace with your repo URL and token):**
  ```bash
  ./config.sh --url https://github.com/<owner>/<repo> --token <REGISTRATION_TOKEN>
  ```

- **Start the runner interactively:**
  ```bash
  ./run.sh
  ```
  - You should see “Listening for Jobs” in the terminal. 

> The video uses the provided commands and shows the terminal output transitioning to “listening for jobs.” 

##### Optional: run as a service (recommended)

To keep the runner alive after disconnects/reboots:

```bash
sudo ./svc.sh install
sudo ./svc.sh start
sudo systemctl status actions.runner.<owner>-<repo>.<name>.service
```

- **Labeling:** During config, you can assign labels (e.g., “self-hosted, linux, x64, build”) to target specific runners in workflows.
- **Ephemeral runners:** For stricter isolation, configure ephemeral mode so each job uses a fresh VM/container (advanced).

---

## Configure the workflow to use the self‑hosted runner

#### Example workflow file

- **Path:** .github/workflows/first-actions.yml 
- **Trigger:** On push. 
- **Matrix:** Python 3.8 and 3.9. 
- **runs-on switch:** Change from “ubuntu-latest” (GitHub‑hosted) to “self-hosted.” 

```yaml
name: Python CI on self-hosted

on:
  push:

jobs:
  build:
    runs-on: self-hosted  # was: ubuntu-latest
    strategy:
      matrix:
        python-version: [3.8, 3.9]
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: ${{ matrix.python-version }}

      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -r requirements.txt || true

      - name: Run tests
        run: |
          python addition.py
          pytest -q || true
```

> The video edits the workflow to switch runs-on to self‑hosted and demonstrates a simple Python job with a 3.8/3.9 matrix. 

---

## Test end‑to‑end and observe runner behavior

- **Make a commit:** Push any change to trigger the workflow. You’ll see a yellow dot while jobs are queued/running. 
- **Watch the runner terminal:** It should display “Running job build on Python 3.9,” then 3.8, or vice versa, per matrix. 
- **Completion:** On success, the yellow dot turns to a green check. This happens when the runner posts results back to GitHub (needs outbound HTTPS). 
- **If it doesn’t run:** Confirm the workflow uses runs-on: self-hosted, the runner is “Online” in Settings ➜ Actions ➜ Runners, and security group rules allow 80/443 both ways. 

> The video shows the real‑time job logs on the runner and the UI status changing to green after both matrix jobs succeed. 

---

## Network, security, and reliability checklist

- **Ports:**  
  - **Inbound:** Open only 80 and 443. Avoid “All traffic.”   
  - **Outbound:** Allow 80 and 443 so the runner can fetch actions and report statuses. 

- **Token hygiene:**  
  - **Registration token:** One‑time, short‑lived; never share or commit it.   
  - **Secrets:** Store credentials in repo/org “Secrets and variables,” never in the workflow. 

- **Instance hardening:**  
  - **Least access:** Use a dedicated security group; restrict SSH to your IP.  
  - **Patching:** Regularly apt update/upgrade; pin action versions.  
  - **Service mode:** Use svc.sh to run as a service; auto‑restart on failure.  
  - **Isolation:** Consider one runner per repo or ephemeral runners for untrusted code.

- **Operational tips:**  
  - **Labels:** Target specific runners via labels (e.g., gpu, large, cache).  
  - **Capacity:** Use multiple runners for parallelism; watch queue times.  
  - **Storage:** Clean work directories on schedule to avoid disk bloat.  
  - **Monitoring:** Export system metrics and Actions job metrics; alert on offline runners.

> The video specifically emphasizes careful port selection, not using “All traffic,” and using GitHub’s Secrets and Variables for sensitive data. 

---

## Cost and management considerations

- **Runner costs:** You pay for EC2 (compute + EBS + data transfer). Right‑size instances, stop them off‑hours, or use auto‑scaling runner pools to control cost.
- **GitHub billing:** Public repos can use GitHub‑hosted minutes free; self‑hosted runners avoid per‑minute charges but shift cost to your infra.
- **Total ownership:** You manage OS patching, runner version updates, logs, and security. Use automation (images, AMIs, IaC) to keep it maintainable.
- **When it’s cheaper:** If your pipelines are heavy or need specialized hardware, self‑hosting often beats hosted minutes. For light workloads on private repos, hosted runners may be simpler.

---

## Quick comparison with Jenkins workers

| Area | Self‑hosted GitHub Actions | Jenkins agents |
|---|---|---|
| Setup | Minimal server‑side; runner per repo/org | Jenkins controller + agents, plugins |
| Workflow as code | YAML in repo, first‑class with PRs | Jenkinsfile, plugin dependencies |
| GitHub integration | Native (PRs, checks, environments, Dependabot) | Requires plugins/webhooks |
| Scaling | Add runners, labels, matrices, parallel jobs | Controller tuning; agents, executors |
| Security | GitHub Secrets, fine‑grained PATs, OIDC | Credentials plugin, RBAC, hardening |
| Cost | You pay infra for runners; hosted free for public | You pay infra for controller + agents |

---

## Troubleshooting and small but important details

- **Architecture mismatch:** Ensure the runner binary matches EC2 architecture (x64 vs ARM64). The video calls this out on the registration screen. 
- **Runner offline:** If the terminal isn’t “listening,” start the service or rerun ./run.sh. 
- **Workflow not picking runner:** Confirm runs-on: self-hosted (or matching labels) and that the runner is online and scoped to the correct repo/org. 
- **Network issues:** If jobs never start or statuses never flip to green, recheck inbound/outbound 80/443 rules; avoid “All traffic.” 
- **Secrets usage:** Store credentials in Settings ➜ Secrets and variables; reference via ${{ secrets.MY_SECRET }} in workflows. The video navigates to this tab during Q&A. 
- **Trigger correctness:** on: push runs on any commit to the repo; add filters (branches, paths) to avoid surprise runs. 
- **Matrix behavior:** Each matrix entry creates a separate job; watch for doubled resource usage/time. The video demonstrates Python 3.8 and 3.9 runs. 

---

Right now, with `pytest -q || true` in place, the job step will **never report a failure to GitHub Actions** — so the overall status will stay green even if tests break. That’s why you wouldn’t get the “red X” on your workflow summary.

If you still want to **see failures** while allowing the pipeline to continue, you’ve got a few good options:

---

## 🔍 Surfacing failures without breaking the whole job

1. **Remove `|| true`**  
   - This is the simplest way — pytest’s non‑zero exit code will fail the step, GitHub will mark the workflow as failed, and you’ll see it instantly in the Actions UI.

2. **Use `continue-on-error: true` in the YAML**  
   ```yaml
   - name: Run tests
     run: pytest -q
     continue-on-error: true
   ```
   - The step itself will show as failed, but the job can still proceed to later steps. That way, you get the red marker for that step in the Actions log.

3. **Capture and report results yourself**  
   - Run pytest normally, but output a JUnit XML report:  
     ```bash
     pytest -q --junitxml=report.xml
     ```
   - Then upload it with the [`actions/upload-artifact`](https://github.com/actions/upload-artifact) action so you can inspect failures after the run.

4. **Conditional logic in the script**  
   ```bash
   pytest -q || TEST_FAILED=$?
   # do other things...
   exit $TEST_FAILED
   ```
   - Lets you run extra steps but still fail the job at the end if any tests failed.

---

💡 In the video’s example, `|| true` was just there so the demo wouldn’t stop mid‑run — in a real CI setup you’d drop it (or use one of these patterns) so a red cross tells you right away that something broke.

Do you want me to tweak your current workflow so it shows red **and** still executes the remaining steps? That’s a common “best of both worlds” approach.
