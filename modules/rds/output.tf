output "rds_instance_endpoint" {
  value = aws_db_instance.rds.endpoint
}

output "rds_subnet_group_name" {
  value = aws_db_subnet_group.rds_subnet_group.name
}
