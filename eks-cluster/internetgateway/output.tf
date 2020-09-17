#create internetgateway output

output "internet_gateway_id" {
  value = aws_internet_gateway.eks_cluster-ing.id
}
