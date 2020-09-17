resource "random_string" "password" {
  length = 16
}

resource "aws_secretsmanager_secret" "rds_postgres_secret" {
  name = var.secret_name
  depends_on = [random_string.password]
}

resource "aws_secretsmanager_secret_version" "db-password" {
  secret_id       = aws_secretsmanager_secret.rds_postgres_secret.id
  secret_string = "{\"password\":\"${random_string.password.result}\"}"
  depends_on = [aws_secretsmanager_secret.rds_postgres_secret]  
}
 

data "aws_secretsmanager_secret_version" "db-password" {
  secret_id = aws_secretsmanager_secret.rds_postgres_secret.id
  depends_on = [aws_secretsmanager_secret_version.db-password]
}

locals {
  db_creds = jsondecode(
    data.aws_secretsmanager_secret_version.db-password.secret_string
  )
}

resource "aws_db_instance" "rds-postgres-instance" {
  identifier                = var.identifier    
  allocated_storage         = var.allocated_storage
  storage_type              = var.storage_type
  engine                    = var.engine
  engine_version            = var.engine_version
  instance_class            = var.instance_class
  name                      = var.name
  username                  = var.username
  password                  = local.db_creds.password
  vpc_security_group_ids    = [var.vpc_security_group_ids]
  db_subnet_group_name      = var.db_subnet_group_name
}

