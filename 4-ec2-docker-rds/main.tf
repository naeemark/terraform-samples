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


# =========================================================
# Securoty Groups
# =========================================================
# Create security group
resource "aws_security_group" "rds_sg" {
  name        = var.rds_sg_name
  description = var.rds_sg_description

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

resource "aws_security_group" "ec2_instance_sg" {
  name        = var.ec2_sg_name
  description = var.ec2_sg_description
  tags        = merge({ Name = "tf-ec2-sg" }, var.tags)

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


# =========================================================
# RDS Database
# =========================================================

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
  publicly_accessible     = var.is_publicly_accessible
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  tags                    = var.tags
}

# =========================================================
# EC2 Instance
# =========================================================
resource "aws_instance" "ec2_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.ec2_instance_sg.id]
  key_name               = var.ssh_connection_key_name
  tags                   = merge({ Name = "ec2-instance" }, var.tags)

  depends_on = [
    aws_db_instance.rds
  ]

  # to pass the variables to script
  user_data_base64 = base64encode("${templatefile("${path.module}/scripts/init_ec2.sh", {
    PORT                  = var.server_port
    SPRING_DATASOURCE_URL = format("jdbc:mysql://%s:%s/fino_cars?createDatabaseIfNotExist=true", aws_db_instance.rds.address, var.db_port)
  })}")
}
