output "endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}


output "iam-role" {
  value = aws_iam_role.role_for_cluster.name
}
