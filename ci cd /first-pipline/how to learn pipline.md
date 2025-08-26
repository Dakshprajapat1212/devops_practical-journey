

read old pipline script and practice 

Try modifying the sample pipelines:

Change the Docker image (e.g., node:16-alpine → node:18-alpine)

Add new stages like SonarQube scan or Kubernetes deploy

Replace node -v with actual build commands like npm run build

can use pipline syntax genrateor 
ou can select actions like “Git checkout” or “Run shell script,” and Jenkins will auto-generate the Groovy code for you.

Example: Generate a script to pull code from GitHub or run a shell command like npm install.
