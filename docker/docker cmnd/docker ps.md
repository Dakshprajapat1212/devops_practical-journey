To check if a Docker container is currently running, use this command:

```bash
docker ps
```

### 🧾 What It Shows:
- **Container ID**
- **Image name**
- **Command used to start it**
- **Status** (e.g., "Up 2 minutes")
- **Ports** exposed
- **Container name**

### 🔍 Example Output:
```bash
CONTAINER ID   IMAGE          COMMAND                  STATUS         PORTS                    NAMES
a1b2c3d4e5f6   mydjangoapp    "python manage.py run…"  Up 5 minutes   0.0.0.0:8000->8000/tcp   webapp_container
```

If you want to see **all containers**, including stopped ones, use:

```bash
docker ps -a
```

Let me know if you want to stop, restart, or inspect a specific container—I can guide you through that too.
