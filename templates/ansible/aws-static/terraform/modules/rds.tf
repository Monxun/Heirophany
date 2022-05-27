resource "aws_db_instance" "aline-db" {

  allocated_storage    = 20
  identifier           = var.db_identifier
  storage_type         = "gp2"
  engine               = var.db_engine
  engine_version       = "8.0"
  instance_class       = "db.m4.large"
  name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql8.0"
}

# CREATE SECURITY GROUP FOR RDS