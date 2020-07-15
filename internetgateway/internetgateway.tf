#variable
variable "vpc_id" {}

variable "subnet_id" {}

# variable "subnet_id2" {}
# variable "subnet_id3" {}
# variable "subnet_id_priv" {}

# Create internetgateway
resource "aws_internet_gateway" "wordpress_igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "wordpress_igw"
  }
}

#create elastic ip
resource "aws_eip" "eip" {
  vpc = true

  tags = {
    Name = "eip"
  }
}

#NAT gateway
resource "aws_nat_gateway" "nt" {
  allocation_id = "${aws_eip.eip.id}"
  subnet_id     = var.subnet_id

  tags = {
    Name = "nt"
  }
}

#routable
resource "aws_route_table" "wordpress-rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wordpress_igw.id
  }

  tags = {
    Name = "wordpress-rt"
  }
}

#assocaiation with subnet
resource "aws_route_table_association" "public-sub" {
  subnet_id = var.subnet_id

  # subnet_id2     = "${var.subnet_id2}"s
  # subnet_id3     = "${var.subnet_id3}"
  route_table_id = aws_route_table.wordpress-rt.id
}

# #assocaiation with subnet
# resource "aws_route_table_association" "public-sub2" {
#   subnet_id = var.subnet_id2
#
#   # subnet_id2     = "${var.subnet_id2}"
#   # subnet_id3     = "${var.subnet_id3}"
#   route_table_id = aws_route_table.wordpress-rt.id
# }
