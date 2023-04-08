terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "ec2_instance" {
  ami                    = "ami-0b695b365bec60938"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ec2_instance_sg.id]
  key_name               = var.ssh_connection_key_name

  tags      = merge({ Name = "ec2-instance" }, var.tags)
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World 1" > index.html
              python3 -m http.server 8080 &
              EOF
}


resource "aws_security_group" "ec2_instance_sg" {
  name = "ec2-instance-sg"
  tags = merge({ Name = "sg_for_EC2_Instance" }, var.tags)

  ingress {
    description = "Allows Trafic on Port: 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allows Trafic on Port: 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
