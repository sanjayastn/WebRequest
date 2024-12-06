# Defining the secret needed to access RDS
resource "aws_secretsmanager_secret" "sm" {
  name = var.sm_name
}

resource "random_password" "password" {
  length  = 16
  special = true
}

resource "aws_secretsmanager_secret_version" "credentials" {
  secret_id = aws_secretsmanager_secret.sm.id
  secret_string = jsonencode({
    username = var.rds_user
    password = random_password.password.result
  })
}
