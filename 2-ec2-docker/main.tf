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
  tags                   = merge({ Name = "ec2-instance" }, var.tags)

  # simple
  # user_data = filebase64("${path.module}/scripts/init.sh")

  # to pass the variables to script
  user_data_base64 = base64encode("${templatefile("${path.module}/scripts/init.sh", {
    PORT = var.server_port
  })}")
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
    description = format("Allows Trafic on Port: %s", var.server_port)
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description      = "Allows Outbound Trafic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
