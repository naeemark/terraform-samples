variable "tags" {
  description = "Custom tags"
  type        = map(any)
  default = {
    "Dir"        = "5-ec2-docker-rds-3t",
    "Owner"      = "tf-samples",
    "Created By" = "terraform"
  }
}

# Security Groups  ---start---
variable "rds_sg_name" {
  type    = string
  default = "database_sg"
}

variable "rds_sg_description" {
  type    = string
  default = "sg for database"
}

variable "ec2_sg_name" {
  type    = string
  default = "ec2_sg"
}

variable "ec2_sg_description" {
  type    = string
  default = "sg for ec2"
}
# Security Groups  ---end---

# RDS  ---start---
variable "instance_class" {
  description = "Databas instance class"
  type        = string
  default     = "db.t3.medium"
}

variable "storage_allocation" {
  description = "Databas allocated storage in GBs"
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "Databas storage type"
  type        = string
  default     = "gp2"
}

variable "db_identifier" {
  description = "Databas instance identifier"
  type        = string
  default     = "tf-database"
}

variable "db_engine" {
  description = "Databas Engine"
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  description = "Databas Engine Version"
  type        = string
  default     = "5.7"
}

variable "db_port" {
  description = "RDS Database Server port"
  type        = number
  default     = 3306
}

variable "db_user_name" {
  description = "Databas User Name"
  type        = string
  default     = "root"
}

variable "db_password" {
  description = "Databas User Password"
  type        = string
  default     = "password"
}

variable "is_publicly_accessible" {
  description = "Should be false"
  type        = bool
  default     = false
}
# RDS  ---end---

# ec2  ---start---
variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0b695b365bec60938"
}

variable "instance_type" {
  description = "Instance type for the EC2"
  type        = string
  default     = "t2.micro"
}

variable "server_mfe_port" {
  description = "Server MFE port for the EC2 instance"
  type        = number
  default     = 80
}
variable "server_port" {
  description = "Server port for the EC2 instance"
  type        = number
  default     = 8080
}

variable "ssh_connection_key_name" {
  description = "SSH connection key name"
  type        = string
  default     = "devops-vm-keypair-2"
}
# ec2  ---end---
