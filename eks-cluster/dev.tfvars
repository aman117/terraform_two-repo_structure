#vpc_cidr
cidr_block = "10.50.0.0/16"

#this name uses everywhare as prefix
name = "eks-cluster"

#subnet cidr block
subnet_cidr = ["10.50.1.0/24", "10.50.2.0/24", "10.50.3.0/24"]

#availability_zone us-east-one
avz = ["us-east-1a", "us-east-1b", "us-east-1c"]

#ingress ports for security group
ingress-ports = [10250, 65535, 443]

#egress ports for security group
egress-ports = [10250, 65535, 443]

#instance type for worker node
instance_type = "t2.micro"

instance_type2 = "t2.nano"

#desired capacity for autoscaling_groups
desired_capacity = "2"

#max size to lounch ec2 instance with autoscaling_group
max_size = "3"

#min size to lounch ec2 instance with autoscaling_group
min_size = "2"

health_check_type = "EC2"
