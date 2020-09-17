resource "aws_db_subnet_group" "rds_postgres_sn_gr" {
  name       = var.db_sg_gr_name
  subnet_ids = var.subnet_ids
}