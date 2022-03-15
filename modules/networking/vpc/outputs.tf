output "db_sg" {
  description = "Return the db security group id"
  value       = aws_security_group.db_sg.id
}

output "db_private_subnets_id" {
  description = "Return a list of db subnets id"
  value       = [for ids in aws_subnet.db_subnets : ids.id]
}