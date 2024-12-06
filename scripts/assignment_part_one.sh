#!/bin/bash

# update the package repository
sudo yum update -y

# install docker in to the ec2s
sudo yum -y install docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user

# ensure docker service is running and write a log with the status
DOCKER_STATUS=$(sudo systemctl status docker)
echo "$DOCKER_STATUS" | sudo tee -a /var/log/docker_status.log

# pull the provided docker image and run it
sudo docker pull yeasy/simple-web
sudo docker run -d -p 80:80 yeasy/simple-web

# verify the deployed application is running and write a log
APP_STATUS=$(sudo docker ps | grep yeasy/simple-web)
echo "$APP_STATUS" | sudo tee -a /var/log/app_status.log
