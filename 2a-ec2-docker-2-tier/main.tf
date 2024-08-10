terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

locals {
  ami_id_first  = "ami-07f19180600636c9c"
  ami_id_second = "ami-088e175082e1fe48f"
}

provider "aws" {
  profile = "muaksite"
  region  = "ap-southeast-2"
}


# Security Group for First EC2 Instance
resource "aws_security_group" "first_instance_sg" {
  name        = "first-instance-sg"
  description = "Allow SSH from anywhere"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group for Second EC2 Instance
resource "aws_security_group" "second_instance_sg" {
  name        = "second-instance-sg"
  description = "Allow SSH only from the first instance"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.first_instance_sg.id]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# First EC2 Instance
resource "aws_instance" "first_instance" {
  ami             = local.ami_id_first
  instance_type   = "t2.micro"
  key_name        = "itadmin-keypair-1"
  security_groups = [aws_security_group.first_instance_sg.name]

  tags = {
    Name = "First Instance"
  }
}

# Second EC2 Instance
resource "aws_instance" "second_instance" {
  ami             = local.ami_id_second
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.second_instance_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              
              # Set password
              echo 'ec2-user:pas$w0rd&6%0' | chpasswd

              # Allow password authentication
              sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

              # Restart the SSH service to apply changes
              systemctl restart sshd
              
              docker run -d -p 80:80 traefik/whoami:latest
              EOF
  tags = {
    Name = "Second Instance"
  }
}

# Output the IP addresses
output "first_instance_ip" {
  value = aws_instance.first_instance.public_ip
}

output "second_instance_public_ip" {
  value = aws_instance.second_instance.public_ip
}

output "second_instance_private_ip" {
  value = aws_instance.second_instance.private_ip
}