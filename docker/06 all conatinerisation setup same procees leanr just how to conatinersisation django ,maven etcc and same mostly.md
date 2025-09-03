# Day 25 | Docker Containerization for Django

---

## Recap of Previous Classes

1. **Concept of Containers**  
   - Explored why containers are lightweight compared to virtual machines.  
   - Analyzed container file and folder structure versus VM’s disk image.  
   - Saw how containers share kernel files yet remain isolated from one another.  

2. **Docker Architecture & Lifecycle**  
   - Understood Docker’s client–server model (daemon, CLI, images, containers).  
   - Traced a container’s lifecycle: build, run, stop, remove.  

3. **Key Docker Terminology**  
   - Docker Daemon, Docker Desktop, Docker Registry.  
   - Installed Docker on an AWS EC2 instance.  
   - Resolved permission issues and ran a simple CLI container.  

---

## Today’s Objective

Deploy the first Django web application as a Docker container. This involves:

- Reviewing a basic Django project structure and workflow.
- Writing a Dockerfile to containerize the application.
- Building and running the container on an EC2 instance.
- Explaining Dockerfile directives, including the distinction between `ENTRYPOINT` and `CMD`.
- Ensuring network access via port mapping and security group rules.

---

## Do You Need Programming Experience?

- Not mandatory to code every line, but a DevOps engineer must understand an application’s workflow:
  - Where it gets dependencies.
  - How services communicate.
  - The flow from request → view → template.
- This knowledge prevents guesswork when containerizing unfamiliar apps.

---

## Django Application Workflow (5-Minute Overview)

1. **Install Python & Django**  
   - Ensure Python is available.  
   - Use `pip install Django` to add the framework.

2. **Create Project Skeleton**  
   - Command: `django-admin startproject <project_name>`  
   - Generates top-level folder with:  
     - `settings.py` – global configuration (databases, middleware, secret keys).  
     - `urls.py` – URL routing and context roots (e.g., `/demo`).  
     - `wsgi.py` – deployment entry point.

3. **Create Application**  
   - Command: `python manage.py startapp demo`  
   - Produces app folder with:  
     - `views.py` – Python functions/classes to handle requests.  
     - `models.py` – ORM models (if needed).  
     - `tests.py`, `admin.py`, `apps.py`, etc.

4. **Add Templates**  
   - Create `templates/` directory inside the app.  
   - Place HTML files referenced by `views.py`.

5. **Run Locally**  
   - Use `python manage.py runserver 0.0.0.0:8000`.  
   - Test in browser at `http://<host_ip>:8000/demo`.

---

## Traditional (Non-Docker) Deployment Challenges

- QA or operations must clone the repo or download an artifact.  
- Install dozens of Python packages via `pip install -r requirements.txt`.  
- Environment mismatch across Windows, macOS, Linux distributions leads to “works on my machine” problems.  

---

## How Docker Solves It

- Bundles application code, Python runtime, dependencies, and system libraries into a single image.  
- Consumers only run two commands:  
  1. `docker build -t <image_name> .`  
  2. `docker run -p <host_port>:<container_port> <image_name>`  
- Eliminates OS-specific issues—only Docker needs installation.

---

## Writing the Dockerfile

Below is the step-by-step breakdown of the Dockerfile used:

```Dockerfile
# 1. Choose a Base Image
FROM ubuntu

# 2. Set Working Directory
WORKDIR /app

# 3. Copy Requirements File  
COPY requirements.txt /app/

# 4. Copy Application Source Code  
COPY devops/ /app/

# 5. Install System Dependencies  
RUN apt-get update \
 && apt-get install -y python3 python3-pip python3-venv

# 6. Switch to Bash Shell for RUN Steps  
SHELL ["/bin/bash", "-c"]

# 7. Create and Activate Virtual Environment, Then Install Python Packages  
RUN python3 -m venv venv1 \
 && source venv1/bin/activate \
 && pip install --no-cache-dir -r requirements.txt

# 8. Expose Application Port  
EXPOSE 8000

# 9. Define Runtime Commands
#    - ENTRYPOINT: non-overridable executable
#    - CMD: user-configurable arguments
CMD source venv1/bin/activate \
 && python3 manage.py runserver 0.0.0.0:8000
```

### Key Dockerfile Directives

- **FROM**: Base OS or language image (`ubuntu` vs. `python:3.9`).  
- **WORKDIR**: Standard location for app code (`/app`).  
- **COPY**: Transfers files from build context into image.  
- **RUN**: Executes commands at build time (installing packages, setting up venv).  
- **SHELL**: Specifies shell for multiline `RUN` commands.  
- **EXPOSE**: Documents container port (does not publish by itself).  
- **ENTRYPOINT vs. CMD**:  
  - **ENTRYPOINT** defines the fixed executable (e.g., `python3`).  
  - **CMD** supplies default arguments (e.g., `manage.py runserver`).  
  - Users can override `CMD` at runtime (e.g., change port), but not `ENTRYPOINT`.

---

## Building & Running the Container

1. **Clone the Repository**  
   ```bash
   git clone https://github.com/your-repo/complete-devops-course.git
   cd complete-devops-course/examples/python-web-app
   ```

2. **Build the Image**  
   ```bash
   docker build -t django-devops .
   ```

3. **Run the Container (with Port Mapping)**  
   ```bash
   docker run -d -p 8000:8000 django-devops
   ```
   - Use `-p <host>:<container>` to forward traffic.

4. **Verify in Browser**  
   Open `http://<EC2_public_IP>:8000/demo`.

---

## EC2 Security Group Configuration

- Navigate to your EC2 instance, select its Security Group.  
- Under **Inbound Rules**, add:  
  - Type: Custom TCP Rule  
  - Port: 8000  
  - Source: 0.0.0.0/0 (or restrict to your IP)  
- Save changes to allow browser access.

---


- Deep dive into Docker CLI commands and networking.  
- Implement multi-stage Docker builds to minimize image size.  
- Explore distroless container images for production security.

---
check docker to heron repo for  practical things .
