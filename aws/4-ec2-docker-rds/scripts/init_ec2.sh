#!/bin/bash

# Create mount volume for logs
  sudo su - root
  mkfs.ext4 /dev/sdf
  mount -t ext4 /dev/sdf /var/log
  
  # Install MySQL Client
  sudo yum install mysql -y

  # Install Docker and Docker-Compose
  sudo yum install docker -y
  sudo usermod -a -G docker ec2-user
  id ec2-user
  sudo yum install python3-pip 
  sudo pip3 install docker-compose

  sudo systemctl enable docker.service
  sudo systemctl start docker.service


sudo docker run -d -p ${PORT}:8080 --name fino-cars-service -e SPRING_DATASOURCE_URL=${SPRING_DATASOURCE_URL} naeemark/fino-cars-service:v1.1.0