variable "tags" {
  description = "Custom tags"
  type        = map(any)
  default = {
    "Dir"        = "2-ec2-docker",
    "Owner"      = "tf-samples",
    "Created By" = "terraform"
  }
}

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

variable "server_port" {
  description = "Server port for the EC2 instance"
  type        = number
  default     = 80
}

variable "cars_api_port" {
  description = "Cars API port for the EC2 instance"
  type        = number
  default     = 8080
}

variable "ssh_connection_key_name" {
  description = "SSH connection key name"
  type        = string
  default     = "itadmin-keypair-1"
}

