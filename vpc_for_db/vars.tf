#-----------------------------------------------

variable "vpc_cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "enable_dns_support" {
  type = bool
  default = true
}

variable "enable_dns_hostnames" {
  type = bool
  default = false
}

variable "vpc_name_tag" {
  type = string
  default = "vpc_for_database"
}

variable "vpc_env_tag" {
  type = string
  default = "dev"
}

variable "availability_zones" {
  type = list
  default = ["us-east-1a","us-east-1b","us-east-1c"]
}

variable "db_subnet_name" {
  type = list
  default = ["db_subnet_a","db_subnet_b","db_subnet_c"]
}

variable "db_subnet_cidr" {
  type = list
  default = ["10.0.20.0/24","10.0.21.0/24","10.0.22.0/24"]
}

variable "db_subnet_env_tag" {
  type = list
  default = ["dev","dev","dev"]
}
