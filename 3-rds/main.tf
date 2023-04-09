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


# Create security group
resource "aws_security_group" "rds_sg" {
  name        = var.sg_name
  description = var.sg_description

  ingress {
    description = format("Allows Trafic on Port: %s", var.db_port)
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge({ Name = "tf-database-sg" }, var.tags)

}

# Create RDS Instance
resource "aws_db_instance" "rds" {
  identifier              = var.db_identifier
  instance_class          = var.instance_class
  allocated_storage       = var.storage_allocation
  storage_type            = var.storage_type
  engine                  = var.db_engine
  engine_version          = var.db_engine_version
  port                    = var.db_port
  username                = var.db_user_name
  password                = var.db_password
  skip_final_snapshot     = true
  backup_retention_period = 0
  apply_immediately       = true
  multi_az                = false
  publicly_accessible     = var.is_publicly_accessible
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  tags                    = var.tags
}

