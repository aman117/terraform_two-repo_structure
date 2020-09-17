variable "storage_size" {
  default = "string"
}

variable "name" {
  default = "string"
}

variable "storage_type" {
  default = "string"
}

variable "version_number" {
  default = "string"
}

variable "class" {
  default = "string"
}

variable "engine" {
  default = "string"
}

variable "parameterGN" {
  default = "string"
}

variable "backup_window" {
  default = "string"
}

variable "subnet1" {
  default = "string"
}

variable "subnet2" {
  default = "string"
}

variable "backup_retention" {
  default = "string"
}

variable "multi_az" {
  default = "bool"
}

variable "allowed_cidr" {
  default = "string"
}

variable "db_identifier" {
  default = "string"
}

variable "db_subnet_group_name" {
  default = "string"
}

variable "port" {
  default = "string"
}

variable "db_security_group" {
  default = "string"
}

variable "vpc_id" {
  default = "string"
}

variable "rds_username" {
  default = "string"
}

#creating the secret
resource "aws_secretsmanager_secret" "rds_password" {
  name = "project_rds_password"
}

#generating random password
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"

  depends_on = [aws_secretsmanager_secret.rds_password]
}

#injecting the generated password
resource "aws_secretsmanager_secret_version" "rds" {
  secret_id     = aws_secretsmanager_secret.rds_password.id
  secret_string = "{\"username\":\"${var.rds_username}\",\"password\":\"${random_password.password.result}\"}"
  #
  depends_on = [random_password.password]
}

data "aws_secretsmanager_secret_version" "cred" {
  # Fill in the name you gave to your secret
  secret_id = aws_secretsmanager_secret.rds_password.name

  depends_on = [aws_secretsmanager_secret_version.rds]
}

locals {
  db_creds = jsondecode(
    data.aws_secretsmanager_secret_version.cred.secret_string
  )
}

#creating security group for rds
resource "aws_security_group" "rds" {
  name = var.db_security_group

  description = "rds_project"
  vpc_id      = var.vpc_id

  # Allow all inbound traffic.
  ingress {
    description = "inbound rule"
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#creating subnet group to specify vpc in which rds will be created
resource "aws_db_subnet_group" "rds" {
  name       = var.db_subnet_group_name
  subnet_ids = [var.subnet1, var.subnet2]

  tags = {
    Name = "db_subnet group"
  }
}

#creating rds
resource "aws_db_instance" "rds" {
  allocated_storage       = var.storage_size
  storage_type            = var.storage_type
  engine                  = var.engine
  engine_version          = var.version_number
  multi_az                = var.multi_az
  instance_class          = var.class
  name                    = var.name
  username                = local.db_creds.username
  password                = local.db_creds.password
  parameter_group_name    = var.parameterGN
  backup_window           = var.backup_window
  backup_retention_period = var.backup_retention
  identifier              = var.db_identifier
  db_subnet_group_name    = var.db_subnet_group_name
  port                    = var.port
  vpc_security_group_ids  = [aws_security_group.rds.id]
}

#output of the endpoint
output "rds_endpoint" {
  description = "the endpoint of the rds"
  value       = aws_db_instance.rds.endpoint
}

output "rds_name" {
  description = "the name of the rds"
  value       = aws_db_instance.rds.name
}

resource "aws_secretsmanager_secret_version" "outputs_to_secret_manager" {
  secret_id     = aws_secretsmanager_secret.rds_password.id
  secret_string = "{\"username\":\"${var.rds_username}\",\"password\":\"${aws_db_instance.rds.password}\",\"db_endpoint\":\"${aws_db_instance.rds.endpoint}\",\"db_name\":\"${aws_db_instance.rds.name}\"}"
  #
  depends_on = [aws_db_instance.rds]
}
