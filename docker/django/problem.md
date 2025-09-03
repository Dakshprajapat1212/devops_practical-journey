
<img width="1470" height="956" alt="Screenshot 2025-09-04 at 1 24 33 AM" src="https://github.com/user-attachments/assets/cac025d3-d612-45ee-8d92-b2837d801cd3" />



Got it 👍 I can see your setup and the error. Let’s write a complete documentation of how you containerized and deployed your first Django app, including the steps, commands, files used, and where the problem occurred (the 404 error you’re seeing).

⸻

📘 Documentation: Containerizing and Running First Django App

1. Environment Setup
	•	OS: Ubuntu (running inside cloud server / VM)
	•	Tools Installed:
	•	Python 3.x
	•	pip / pip3
	•	Django
	•	Docker
	•	Docker Compose

⸻

2. Create Django Project

# Install Django
pip install django

# Start project (project name: devops)
django-admin startproject devops

cd devops

# Create a sample app (name: demo)
python manage.py startapp demo


⸻

3. Update settings.py

Inside devops/settings.py:

INSTALLED_APPS = [
    ...
    'demo',
]

# Allow all hosts for testing
ALLOWED_HOSTS = ['*']


⸻

4. Configure URLs

devops/urls.py

from django.contrib import admin
from django.urls import path
from demo import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('demo/', views.home),   # Added demo app route
]

demo/views.py

from django.http import HttpResponse

def home(request):
    return HttpResponse("Hello, Django is working in container!")


⸻

5. Run Locally (without Docker)

python manage.py runserver 0.0.0.0:8000

	•	Visit:
	•	✅ http://127.0.0.1:8000/demo/ → Works
	•	❌ http://127.0.0.1:8000/ → Shows Page not found (404)
	•	Reason: No route defined for / in urls.py.

⸻

6. Dockerization

Dockerfile

FROM python:3.10

# Set work directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy project files
COPY . .

# Expose port
EXPOSE 8000

# Run Django server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

requirements.txt

Django>=4.0


⸻

7. Build & Run Container

# Build image
docker build -t django-app .

# Run container
docker run -d -p 8000:8000 django-app


⸻

8. Access from Browser
	•	Open: http://<server-ip>:8000/
	•	❌ Error: Page not found (404)
	•	Reason: Django only has /demo/ and /admin/ routes.
	•	Open: http://<server-ip>:8000/demo/
	•	✅ Response: "Hello, Django is working in container!"

⸻

9. Problem Faced

❌ Error Seen

Page not found (404)
Request URL: http://<server-ip>:8000/
The empty path didn’t match any of these:
1. demo/
2. admin/

✅ Cause
	•	No URL mapped for root (/) in urls.py.

🔧 Fix

Add a home route in devops/urls.py:

from django.http import HttpResponse

def index(request):
    return HttpResponse("Welcome to my first Django app!")

urlpatterns = [
    path('', index),  # Root path fixed
    path('demo/', views.home),
    path('admin/', admin.site.urls),
]


now im trying to solve this im dcletering complete repo and complete dokcer image and image  again trying to setup cause its devloper issues need to fix sonthing 

Now http://<server-ip>:8000/ will also work.

⸻

10. Final Notes
	•	What worked: Containerization, /demo/ route.
	•	What failed: Default / path not defined.
	•	How to fix: Add an index view for /.

⸻

Good question 👍
Here’s how you can delete Docker images step by step:

⸻

1. List all images

docker images

or

docker image ls

You’ll see output like:

REPOSITORY     TAG       IMAGE ID       CREATED        SIZE
django-app     latest    a1b2c3d4e5f6   1 hour ago     450MB


⸻ i will splve it by the deketing the project and images will try gqsian 

2. Delete image by name (repo:tag)

docker rmi django-app:latest


⸻

3. Delete image by ID

docker rmi a1b2c3d4e5f6


⸻

4. Force delete (if container is still using it)

docker rmi -f a1b2c3d4e5f6


⸻

5. Remove all dangling (unused) images

docker image prune


⸻

6. Remove all images (⚠️ careful, deletes everything!)

docker rmi $(docker images -aq)


⸻

👉 Hannu, do you want me to also give you the commands to stop and remove containers first (so the image isn’t “in use” error comes)?
