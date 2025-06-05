# Create a Database instance
resource "aws_db_instance" "db_instance" {
  allocated_storage      = var.db_allocated_storage
  db_name                = var.db_name
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.db_instance_class
  username               = "dojo_user"
  password               = jsondecode(data.aws_secretsmanager_secret_version.db_password.secret_string)["dev_dojo_db_password"]
  parameter_group_name   = "default.mysql8.0"
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [var.security_group_db]
  skip_final_snapshot    = true
  publicly_accessible = false

  tags = {
    Name = "${var.project_name}-demo-DB-instance"
  }
}

# create RDS instance subnet group
resource "aws_db_subnet_group" "db_subnet_group" {
  subnet_ids = [var.subnet_db_1, var.subnet_db_2]
}

data "aws_secretsmanager_secret" "db_password" {
  name = "dev_dojo_db_password"  # The name of the secret
}

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = data.aws_secretsmanager_secret.db_password.id
}