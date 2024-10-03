#!/bin/bash
sudo apt update -y
docker run -d \
  --name jenkins \
  --network officeportable-network \
  -p 8083:8083 \
  -p 50000:50000 \
  -v ~/jenkins_home:/var/jenkins_home \
  -e JENKINS_OPTS="--httpPort=8083" \
  jenkins/jenkins:lts



#docker
sudo chmod 777 /var/run/docker.sock
docker run -d --network officeportable-network --name sonar -p 9000:9000 sonarqube:lts-community

#trivy

sudo apt-get install wget apt-transport-https gnupg lsb-release -y
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy -y