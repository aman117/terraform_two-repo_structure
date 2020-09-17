variable "name" {
  type    = string
  default = "mysql_rds"
}

variable "storage_size" {
  type    = string
  default = "20"
}

variable "storage_type" {
  type    = string
  default = "gp2"
}

variable "engine" {
  type    = string
  default = "mysql"
}

variable "version_number" {
  type    = string
  default = "5.7"
}

variable "class" {
  type    = string
  default = "db.t2.micro"
}

variable "parameterGN" {
  type    = string
  default = "default.mysql5.7"
}

variable "backup_window" {
  type    = string
  default = "09:46-10:16"
}

variable "backup_retention" {
  type    = string
  default = "7"
}

variable "subnet1" {
  type    = string
  default = "subnet-089409880c7475eb0"
}

variable "subnet2" {
  type    = string
  default = "subnet-0a94aad6dc73fe69a"
}

variable "multi_az" {
  type    = bool
  default = false
}

variable "db_identifier" {
  type    = string
  default = "project"
}

variable "db_subnet_group_name" {
  type    = string
  default = "project_db_sub_group"
}

variable "port" {
  type    = string
  default = "3306"
}

variable "vpc_id" {
  type    = string
  default = "vpc-0b7a20d283da1666c"
}

variable "db_security_group" {
  type    = string
  default = "mysql_rds_sg"
}

variable "allowed_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "rds_username" {
  type    = string
  default = "rds_admin"
}
