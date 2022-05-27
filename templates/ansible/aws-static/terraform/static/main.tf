provider "aws" {
}

data "aws_secretsmanager_secret" "alinedbSecret" {
  name = var.secret_key_name
}
data "aws_secretsmanager_secret_version" "alinedbSecret-current" {
  secret_id     = data.aws_secretsmanager_secret.alinedbSecret.id
  version_stage = "AWSCURRENT"
}
locals {
  db_creds = jsondecode(data.aws_secretsmanager_secret_version.dbalineSecret-current.dbalineSecret)
}
  