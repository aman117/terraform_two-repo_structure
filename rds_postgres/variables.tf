# RDS Postgres Security Group
variable "db_sg_name" {
  description = "RDS Postgres Security Group name"
  type        = string
  default     = "rds_postgres_sg"
}

variable "vpc_id" {
  description = "RDS Postgres Security Group sg_ingress_cidr_block"
  type        = string
  default     = "vpc-096deb33261afb385"
}

variable "from_port" {
  description = "RDS Postgres Security Group incoming port"
  type        = string
  default     = "5432"
}

variable "to_port" {
  description = "RDS Postgres Security Group outgoing port"
  type        = string
  default     = "5432"
}

variable "cidr_blocks" {
  description = "RDS Postgres Security Group sg_ingress_cidr_block"
  type        = string
  default     = "10.0.0.0/16"
}

# RDS Postgres Subnet Group
variable "db_sg_gr_name" {
  description = "Creates a unique name for RDS Subnet Group"
  type        = string
  default     = "rds-postgres-sn-group"
}

variable "subnet_ids" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
  default     = ["subnet-00bcc4cbbd5a005cb","subnet-00bcc4cbbd5a005cb","subnet-0d57f62e5d07cd1ce"]
}

# RDS Postgres Secret
variable "secret_name" {
  description = "RDS Postgres Secret Name"
  type        = string
  default     = "test-8"
}

# RDS Postgres Instance
variable "identifier" {
  description = "The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier"
  type        = string
  default     = "rds-postgres"
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that this behaviour is different from the AWS web console, where the default is 'gp2'."
  type        = string
  default     = "gp2"
}

variable "engine" {
  description = "The database engine to use"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
  default     = "9.6.9"
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.t2.micro"
}

variable "name" {
  description = "The DB name to create. If omitted, no database is created initially"
  type        = string
  default     = "rdspostgres"
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
  default     = "student"
}

variable "vpc_security_group_ids" {
  description = "Security ID's for DB Instance"
  type        = string
  default     = "sg-016979fa40c9d2c1f"
}

variable "db_subnet_group_name" {
  description = "Creates a unique name for RDS Subnet Group"
  type        = string
  default     = "rds-postgres-sn-group"
}



