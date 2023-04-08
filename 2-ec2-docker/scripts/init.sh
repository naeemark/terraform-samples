#!/bin/bash

# Create mount volume for logs
  sudo su - root
  mkfs.ext4 /dev/sdf
  mount -t ext4 /dev/sdf /var/log
  
  # Install MySQL Client
  # sudo yum install mysql -y

  # Install Docker and Docker-Compose
  sudo yum install docker -y
  sudo usermod -a -G docker ec2-user
  id ec2-user
  sudo yum install python3-pip 
  sudo pip3 install docker-compose

  sudo systemctl enable docker.service
  sudo systemctl start docker.service


  sudo docker run -d -p ${PORT}:80 --name hello-world tutum/hello-world:latest

  # sudo docker run -d -p 80:3000 --name mfe1 -e END=${PORT} -e HOST_NAME=`hostname -f` naeemark/poc-repo:mfe