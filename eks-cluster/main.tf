module "aws_vpc" {
  cidr_block = var.cidr_block
  name       = var.name
  source     = "./vpc"
}

module "aws_subnet" {
  source      = "./subnet"
  subnet_cidr = var.subnet_cidr
  avz         = var.avz
  vpc_id      = module.aws_vpc.vpc_id
}

module "aws_internet_gateway" {
  source = "./internetgateway"
  vpc_id = module.aws_vpc.vpc_id
  name   = var.name
}

module "aws_security_group" {
  source  = "./sg"
  vpc_id  = module.aws_vpc.vpc_id
  name    = var.name
  ingress = var.ingress-ports
  egress  = var.egress-ports
}

module "aws_route_table" {
  source              = "./routable"
  name                = var.name
  vpc_id              = module.aws_vpc.vpc_id
  subnet_id           = module.aws_subnet.subnet_id
  internet_gateway_id = module.aws_internet_gateway.internet_gateway_id
}

module "aws_autoscaling-with-lt" {
  source                                   = "./launch_temp"
  name                                     = var.name
  instance_type                            = var.instance_type
  instance_type2                           = var.instance_type2
  sg_id                                    = module.aws_security_group.sg_id
  subnet_id                                = module.aws_subnet.subnet_id
  image_id                                 = data.aws_ami.eks-worker.id
  avz                                      = var.avz
  desired_capacity                         = var.desired_capacity
  max_size                                 = var.max_size
  min_size                                 = var.min_size
  health_check_type                        = var.health_check_type
  on_demand_base_capacity                  = 1
  on_demand_percentage_above_base_capacity = 20
  spot_allocation_strategy                 = "lowest-price"
  spot_instance_pools                      = 5
  # spot_max_price                           = 0.010
}

module "aws_eks_cluster" {
  source    = "./eks"
  name      = var.name
  sg_id     = module.aws_security_group.sg_id
  subnet_id = module.aws_subnet.subnet_id
}
