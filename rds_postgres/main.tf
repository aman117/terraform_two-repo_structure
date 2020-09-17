module "rds_postgres_sg" {
  source = "./modules/db_security_group"

  db_sg_name        = var.db_sg_name
  vpc_id            = var.vpc_id
  from_port         = var.from_port
  to_port           = var.to_port
  cidr_blocks       = var.cidr_blocks
}

module "rds_postgres_sn_gr" {
  source = "./modules/db_subnet_group"

  db_sg_gr_name   = var.db_sg_gr_name
  subnet_ids      = var.subnet_ids
}

module "rds-postgres-instance" {
  source = "./modules/db_instance"

  identifier                = var.identifier
  allocated_storage         = var.allocated_storage
  storage_type              = var.storage_type 
  engine                    = var.engine
  engine_version            = var.engine_version
  instance_class            = var.instance_class
  name                      = var.name
  username                  = var.username
  vpc_security_group_ids    = var.vpc_security_group_ids
  secret_name               = var.secret_name
  db_subnet_group_name      = var.db_subnet_group_name
}

