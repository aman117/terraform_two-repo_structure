variable "identifier" {
  description = "The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier"
  type        = string
}


variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = string
}

variable "storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that this behaviour is different from the AWS web console, where the default is 'gp2'."
  type        = string
  default     = "gp2"
}

variable "engine" {
  description = "The database engine to use"
  type        = string
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "name" {
  description = "The DB name to create. If omitted, no database is created initially"
  type        = string
  default     = ""
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "Security ID's for DB Instance"
  type        = string
}

variable "db_subnet_group_name" {
  description = "Creates a unique name for RDS Subnet Group"
  type        = string
  default     = "rds-postgres-sn-group"
}


# DB Secter

variable "secret_name" {
  description = "RDS Postgres Secret Name"
  type        = string
}
