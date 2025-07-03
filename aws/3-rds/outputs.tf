output "db_endpoint" {
  description = "database endpoint"
  value       = aws_db_instance.rds.address
}

output "db_sg_id" {
  value = aws_security_group.rds_sg.id
}
