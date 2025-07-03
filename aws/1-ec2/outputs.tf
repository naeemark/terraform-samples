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
  value = "http://${aws_instance.ec2_instance.public_dns}:8080"
}
