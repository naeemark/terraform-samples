variable "tags" {
  description = "Custom tags"
  type        = map(any)
  default = {
    "Dir"        = "1-ec2",
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

  description = "Instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "ssh_connection_key_name" {
  description = "SSH connection key name"
  type        = string
  default     = "devops-vm-keypair-2"
}

