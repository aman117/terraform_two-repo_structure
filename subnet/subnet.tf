#variable
variable "vpc_id" {}

# Declare the data source
data "aws_availability_zones" "avz" {
  state = "available"
}

#Create public subnets in availablity zone 1
resource "aws_subnet" "subnet1" {
  availability_zone       = data.aws_availability_zones.avz.names[0]
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "subnet1"
  }
}

resource "aws_subnet" "subnet2" {
  availability_zone       = data.aws_availability_zones.avz.names[0]
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "subnet2"
  }
}

#Create public subnet availability zone 2
resource "aws_subnet" "subnet3" {
  availability_zone       = data.aws_availability_zones.avz.names[1]
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "subnet3"
  }
}

#Create private subnet in availability zone 2
resource "aws_subnet" "subnet4" {
  availability_zone = data.aws_availability_zones.avz.names[1]
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.4.0/24"

  tags = {
    Name = "subnet4"
  }
}

#create private subnet in avaibility zone 3
resource "aws_subnet" "subnet5" {
  availability_zone = data.aws_availability_zones.avz.names[2]
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.5.0/24"

  tags = {
    Name = "subnet5"
  }
}

resource "aws_subnet" "subnet6" {
  availability_zone = data.aws_availability_zones.avz.names[2]
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.6.0/24"

  tags = {
    Name = "subnet6"
  }
}

#output
output "subnet_id" {
  value = aws_subnet.subnet1.id
}

output "subnet_id2" {
  value = aws_subnet.subnet2.id
}

output "subnet_id3" {
  value = aws_subnet.subnet3.id
}

# output "subnet_id_priv" {
#   value = "${aws_subnet.subnet5.id}"
# }
