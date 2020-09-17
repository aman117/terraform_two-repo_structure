# terraform {
#   backend "s3" {
#     bucket         = "terraform-remote-state-bucket-312"
#     dynamodb_table = "terraformstatetable"
#     key            = "aws_eks_cluster/tfstate.tfstate"
#     region         = "us-east-1"
#   }
# }
