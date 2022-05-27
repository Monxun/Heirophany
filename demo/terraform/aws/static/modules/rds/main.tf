data "aws_secretsmanager_secret" "dbkeys" {
  name = var.secret_key_name
}

data "aws_secretsmanager_secret_version" "db_creds_version" {
  secret_id     = data.aws_secretsmanager_secret.dbkeys.id
  version_stage = "AWSCURRENT"
}

locals {
  db_creds = jsondecode(data.aws_secretsmanager_secret_version.db_creds_version.secret_string)
}

resource "aws_db_instance" "aline-db" {
  count                = var.rds_flag ? 1 : 0
  allocated_storage    = 20
  identifier           = local.db_creds["dbInstanceIdentifier"]
  storage_type         = "gp2"
  engine               = local.db_creds["engine"]
  engine_version       = "8.0"
  instance_class       = var.db_instance_class
  name                 = var.db_name
  username             = local.db_creds["username"]
  password             = local.db_creds["password"]
  parameter_group_name = "default.mysql8.0"
}

resource "aws_db_parameter_group" "default" {
  count       = var.rds_flag ? 1 : 0
  name        = "${var.db_name}-param-group"
  description = "Aline parameter group for mysql8.0"
  family      = "mysql8.0"
  parameter {
    name  = "character_set_server"
    value = "utf8"
  }
  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}