# alb security group id
output "alb_security_group_id" {
  value = aws_security_group.alb_security_group.id
}

# ec2 security group id
output "ec2_security_group_id" {
  value = aws_security_group.ec2_security_group.id
}

# jump server security group id
output "jump_server_security_group_id" {
  value = aws_security_group.jump_server_security_group.id
}

# DB security group id 
output "db_security_group_id" {
  value = aws_security_group.db_security_group.id
}