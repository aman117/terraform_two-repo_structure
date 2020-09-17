variable "db_sg_name" {
  description = "RDS Postgres Security Group name"
  type        = string
}

variable "vpc_id" {
  description = "VPC Id for RDS Postgres SG"
  type        = string
}

variable "from_port" {
  description = "RDS Postgres Security Group incoming port"
  type        = string
}

variable "to_port" {
  description = "RDS Postgres Security Group outgoing port"
  type        = string
}

variable "cidr_blocks" {
  description = "RDS Postgres Security Group sg_ingress_cidr_block"
  type        = string
}