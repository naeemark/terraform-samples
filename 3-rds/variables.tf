variable "tags" {
  description = "Custom tags"
  type        = map(any)
  default = {
    "Dir"        = "3-rds",
    "Owner"      = "tf-samples",
    "Created By" = "terraform"
  }
}

variable "instance_class" {
  description = "Databas instance class"
  type        = string
  default     = "db.t2.micro"
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
  default     = "admin"
}

variable "db_password" {
  description = "Databas User Password"
  type        = string
  default     = "passw0rd"
}

variable "is_publicly_accessible" {
  description = "Should be false"
  type        = bool
  default     = true
}

variable "sg_name" {
  type    = string
  default = "database_sg"
}

variable "sg_description" {
  type    = string
  default = "sg for database"
}
