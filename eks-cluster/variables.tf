#vpc_cidr
variable "cidr_block" {}
#this name uses everywhare
variable "name" {}

#subnet cidr block
variable "subnet_cidr" {
  type = list(string)
}
#availability_zone us-east-one
variable "avz" {
  type = list(string)
}
#ingress ports for security group
variable "ingress-ports" {
  type = list(number)
}
#egress ports for security group
variable "egress-ports" {
  type = list(number)
}

#instance type for worker node
variable "instance_type" {}

variable "instance_type2" {}
#desired capacity for autoscaling_groups
variable "desired_capacity" {}
#max size to lounch ec2 instance with autoscaling_group
variable "max_size" {}
#min size to lounch ec2 instance with autoscaling_group
variable "min_size" {}

variable "health_check_type" {}

data "aws_ami" "eks-worker" {
  owners = ["602401143452"] # Amazon EKS AMI Account ID
  filter {
    name   = "name"
    values = ["amazon-eks-node-1.16-v20200904"]
  }
}
