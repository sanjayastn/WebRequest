data "aws_vpc" "default" {
  default = true
}

data "aws_secretsmanager_secret" "rds_credentials" {
  name       = var.sm_name
  depends_on = [module.sm]
}

data "aws_secretsmanager_secret_version" "rds_credentials" {
  secret_id = data.aws_secretsmanager_secret.rds_credentials.id
}

locals {
  rds_credentials = jsondecode(data.aws_secretsmanager_secret_version.rds_credentials.secret_string)
}
