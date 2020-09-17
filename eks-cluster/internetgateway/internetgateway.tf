# Create internetgateway
resource "aws_internet_gateway" "eks_cluster-ing" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.name}-igw"
  }
}
