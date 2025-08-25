<img width="1470" height="956" alt="Screenshot 2025-08-25 at 1 46 31 PM" src="https://github.com/user-attachments/assets/fe040e54-81e5-44b5-87bd-e56cdfdacf25" />

ubuntu@ip-172-31-38-189:~$ cat /var/lib/jenkins/secrets/initialAdminPassword
cat: /var/lib/jenkins/secrets/initialAdminPassword: Permission denied
ubuntu@ip-172-31-38-189:~$


cat: /var/lib/jenkins/secrets/initialAdminPassword: Permission denied
ubuntu@ip-172-31-38-189:~$ sudo cat /var/lib/jenkins/secrets/initialAdminPassword

2d3f96e1a85c4416b35fd9b3ef2101c8


ubuntu@ip-172-31-38-189:~$


Exactly — **regular users cannot perform privileged tasks unless they’re explicitly granted permission**. That’s the whole point of having a layered security model in Linux and other Unix-like systems.

---

## 🔐 What Counts as a "Privileged Task"?

These are actions that can affect the entire system or other users, such as:
- Installing or removing software
- Accessing system files (like `/etc/passwd` or Jenkins secrets)
- Starting or stopping services
- Changing network settings
- Creating or deleting users

These tasks require **root-level access**, which is restricted to prevent accidental damage or malicious activity.

---

## 🧰 How Can a User Perform Privileged Tasks?

Only if:
1. They are part of the **`sudo` group** (or listed in the `sudoers` file)
2. They use the `sudo` command before the privileged action

Example:
```bash
sudo apt install nginx
```

Without `sudo`, a regular user would get a **“Permission denied”** error — just like in the Jenkins example you saw on GitHub.

---

## 🧠 Why This Is Smart

It’s like giving someone access to a car:
- You don’t hand over the keys to just anyone.
- You give access only to trusted drivers.
- And you keep a log of who drove and when.

This keeps your system secure, stable, and accountable.




---

If you’re curious, I can show you how to check which users have `sudo` access or how to safely grant it to someone. Want to dive into that?
