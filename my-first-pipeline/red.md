
when u builidng in jenkins chek docker ps -a 

its show all process running  in building as completed all deleted


<img width="1470" height="956" alt="Screenshot 2025-08-27 at 12 32 32 AM" src="https://github.com/user-attachments/assets/5e141a9d-f2c3-489c-9008-6280d7bf4171" />
<img width="1470" height="956" alt="Screenshot 2025-08-27 at 12 33 03 AM" src="https://github.com/user-attachments/assets/7b9fa6d6-ee4b-4f11-bd87-37369ca13f0c" />
<img width="1470" height="956" alt="Screenshot 2025-08-27 at 12 33 27 AM" src="https://github.com/user-attachments/assets/e37a548a-0a5d-43bc-9b52-1d87eade8a99" />
<img width="1470" height="956" alt="Screenshot 2025-08-27 at 12 33 27 AM" src="https://github.com/user-attachments/assets/9e484380-3137-4599-9cb2-9d3333a46a33" />

Started by user daksh
Obtained my-first-pipeline/jenkinsfile from git https://github.com/Dakshprajapat1212/devops_practical-journey
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/workspace/first jenkins
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
No credentials specified
Cloning the remote Git repository
Cloning repository https://github.com/Dakshprajapat1212/devops_practical-journey
 > git init /var/lib/jenkins/workspace/first jenkins # timeout=10
Fetching upstream changes from https://github.com/Dakshprajapat1212/devops_practical-journey
 > git --version # timeout=10
 > git --version # 'git version 2.43.0'
 > git fetch --tags --force --progress -- https://github.com/Dakshprajapat1212/devops_practical-journey +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git config remote.origin.url https://github.com/Dakshprajapat1212/devops_practical-journey # timeout=10
 > git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* # timeout=10
Avoid second fetch
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision 8489d1d59ff17273634673f482cc7e5730cef8ec (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 8489d1d59ff17273634673f482cc7e5730cef8ec # timeout=10
Commit message: "Create jenkinsfile"
First time build. Skipping changelog.
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] isUnix
[Pipeline] withEnv
[Pipeline] {
[Pipeline] sh
+ docker inspect -f . node:16-alpine

Error: No such object: node:16-alpine
[Pipeline] isUnix
[Pipeline] withEnv
[Pipeline] {
[Pipeline] sh
+ docker pull node:16-alpine
16-alpine: Pulling from library/node
7264a8db6415: Pulling fs layer
eee371b9ce3f: Pulling fs layer
93b3025fe103: Pulling fs layer
d9059661ce70: Pulling fs layer
d9059661ce70: Waiting
7264a8db6415: Verifying Checksum
7264a8db6415: Download complete
93b3025fe103: Verifying Checksum
93b3025fe103: Download complete
7264a8db6415: Pull complete
d9059661ce70: Verifying Checksum
d9059661ce70: Download complete
eee371b9ce3f: Verifying Checksum
eee371b9ce3f: Download complete
eee371b9ce3f: Pull complete
93b3025fe103: Pull complete
d9059661ce70: Pull complete
Digest: sha256:a1f9d027912b58a7c75be7716c97cfbc6d3099f3a97ed84aa490be9dee20e787
Status: Downloaded newer image for node:16-alpine
docker.io/library/node:16-alpine
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] withDockerContainer
Jenkins does not seem to be running inside a container
$ docker run -t -d -u 111:113 -w "/var/lib/jenkins/workspace/first jenkins" -v "/var/lib/jenkins/workspace/first jenkins:/var/lib/jenkins/workspace/first jenkins:rw,z" -v "/var/lib/jenkins/workspace/first jenkins@tmp:/var/lib/jenkins/workspace/first jenkins@tmp:rw,z" -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** -e ******** node:16-alpine cat
$ docker top 6713a44b34cef9d6248130df976542541def37c0abc3197291ae4f443f8c4836 -eo pid,comm
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Test)
[Pipeline] sh
+ node --version
v16.20.2
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
$ docker stop --time=1 6713a44b34cef9d6248130df976542541def37c0abc3197291ae4f443f8c4836
$ docker rm -f --volumes 6713a44b34cef9d6248130df976542541def37c0abc3197291ae4f443f8c4836
[Pipeline] // withDockerContainer
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS


<img width="1470" height="956" alt="Screenshot 2025-08-27 at 12 36 47 AM" src="https://github.com/user-attachments/assets/497d1fbd-2353-46b1-bde1-1bac8e203e51" />
jenkins is talking to contianer give me conatiber run pipline and check node version


process is done then container is done

in vm based we were using diffetent dependy need to maintence and cost

on this just changing pipline and automatinf   things using pipline 




