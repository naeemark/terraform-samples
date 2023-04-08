output "instance_id" {
  value = aws_instance.ec2_instance.id
}

output "instance_sg_id" {
  value = aws_security_group.ec2_instance_sg.id
}

output "instance_ip_addr" {
  value = aws_instance.ec2_instance.public_ip
}

output "instance_url" {
  value = format("http://%s:%s", aws_instance.ec2_instance.public_dns, var.server_port)
}
