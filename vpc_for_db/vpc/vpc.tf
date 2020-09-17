#-----------------------------------------------

variable "vpc_cidr_block" {
  type = string
}

variable "enable_dns_support" {
  type = bool
}

variable "enable_dns_hostnames" {
  type = bool
}

variable "vpc_name_tag" {
  type = string
}

variable "vpc_env_tag" {
  type = string
}

variable "availability_zones" {
  type = list
}

variable "db_subnet_name" {
  type = list
}

variable "db_subnet_cidr" {
  type = list
}

variable "db_subnet_env_tag" {
  type = list
}




resource "aws_vpc" "vpc_for_db" {

  cidr_block              = var.vpc_cidr_block
  enable_dns_support      = var.enable_dns_support
  enable_dns_hostnames    = var.enable_dns_hostnames

  tags                    = {
    Name                  = var.vpc_name_tag
    Environment           = var.vpc_env_tag
  }
}




resource "aws_subnet" "db_subnets" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.vpc_for_db.id
  cidr_block              = var.db_subnet_cidr[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = false
  tags                    = {
    Name                  = var.db_subnet_name[count.index]
    Environment           = var.db_subnet_env_tag[count.index]
  }
}



output "vpc_for_db" {
  value                 = "${aws_vpc.vpc_for_db.id}"
}

output "db_subnets" {
  value                 = "${aws_subnet.db_subnets[*].id}"
}
