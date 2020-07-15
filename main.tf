module "aws_vpc" {
  source = "./vpc"
}

module "aws_subnet" {
  source = "./subnet"
  vpc_id = module.aws_vpc.vpc_id
}

module "aws_internet_gateway" {
  source    = "./internetgateway"
  vpc_id    = module.aws_vpc.vpc_id
  subnet_id = module.aws_subnet.subnet_id
}

module "aws_security_group" {
  source = "./sg"

  vpc_id = module.aws_vpc.vpc_id

  # sg     = "${module.aws_security_group.sg}"
}
module "aws_key_pair" {
  source = "./key"
}

module "aws_instance" {
  source    = "./instance"
  key_name  = module.aws_key_pair.key_name
  sg_id     = module.aws_security_group.sg_id
  subnet_id = module.aws_subnet.subnet_id
}
