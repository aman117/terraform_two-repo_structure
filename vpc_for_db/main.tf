#-----------------------------------------------


module "vpc_for_db" {
  source                = "./vpc"
  vpc_cidr_block        = var.vpc_cidr_block
  enable_dns_support    = var.enable_dns_support
  enable_dns_hostnames  = var.enable_dns_hostnames
  vpc_name_tag          = var.vpc_name_tag
  vpc_env_tag           = var.vpc_env_tag
  availability_zones    = var.availability_zones
  db_subnet_name        = var.db_subnet_name
  db_subnet_cidr        = var.db_subnet_cidr
  db_subnet_env_tag     = var.db_subnet_env_tag
}
