# #output of vpc_id
output "vpc_id" {
  value = aws_vpc.eks_cluster.id
}
