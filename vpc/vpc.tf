# Create a VPC
resource "aws_vpc" "wordpress-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "wordpress-vpc"
  }
}

#output of vpc_id
output "vpc_id" {
  value = aws_vpc.wordpress-vpc.id
}
