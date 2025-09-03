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
# What “knowing all applications” really means in DevOps

When the instructor says “you should have knowledge of all applications,” he isn’t asking you to be a full-stack expert in every language. He’s driving at a core DevOps principle: to package, deploy, and troubleshoot *any* app, you need to quickly map its workflow—its dependencies, build steps, configs, and startup commands.

---

## 1. It’s about *workflow*, not full coding expertise

- You don’t have to write every line of Java, Python, or Go.  
- You do need to spot:
  - Where the app declares its dependencies (`package.json`, `requirements.txt`, `pom.xml`).
  - How it builds or compiles (React build, Django collectstatic, Maven package).
  - Which file or command boots it up (`npm start`, `python manage.py runserver`, `java -jar …`).
  - Where configuration lives (environment variables, YAML/JSON files, `settings.py`, `application.properties`).

---

## 2. Translate your MERN skill set to other stacks

You’ve already internalized these steps for Node/React. The same five-layer Docker pattern applies elsewhere:

| Docker Layer          | MERN                                | Django                             | Spring Boot                       |
|-----------------------|-------------------------------------|------------------------------------|-----------------------------------|
| Base image            | `node:16-alpine`                    | `python:3.10-slim`                 | `openjdk:17-jdk-slim`             |
| Copy dependency file  | `package*.json`                     | `requirements.txt`                 | `pom.xml` / `build.gradle`        |
| Install dependencies  | `npm ci --only=production`          | `pip install -r requirements.txt`  | `mvn dependency:go-offline -B`    |
| Copy source & build   | `COPY . .` → `npm run build`         | `COPY . .` → `python manage.py collectstatic` | `COPY . .` → `mvn package -DskipTests` |
| Expose & run          | `EXPOSE 3000` → `CMD ["npm","start"]` | `EXPOSE 8000` → `CMD ["gunicorn","proj.wsgi:app","-b","0.0.0.0:8000"]` | `EXPOSE 8080` → `ENTRYPOINT ["java","-jar","target/app.jar"]` |

By practicing this once per new framework—just a Hello-World app—you build the muscle to containerize *any* web service in minutes.

---

## 3. How to answer this in an interview

Interviewer: “Do you need development knowledge for DevOps?”  
Your answer:  
> “Absolutely. I start by inspecting the key artifacts—`package.json`, `requirements.txt`, or `pom.xml`—to install dependencies. I identify the build step (React build, Django collectstatic, Maven package) and the startup command (`npm start`, `gunicorn`, `java -jar`). Then I structure a Dockerfile in five layers: base image, deps install, copy & build, expose port, and CMD/ENTRYPOINT. This lets me reliably containerize, test, and ship any application stack.”

That shows you “know the shape” of every app without being its primary developer.

---

## 4. Next steps to build that knowledge

- Pick one new stack (Django, Spring Boot, Go, .NET) and repeat the five-step Docker drill.  
- Read each framework’s quickstart guide to spot its skeleton files.  
- Practice spinning up a tiny service, containerizing it, and running it locally.  

In time, you’ll be the person in your team who can onboard *any* codebase into your CI/CD pipelines—exactly what top-tier DevOps roles demand.
