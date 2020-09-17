# configuring backend and locking

terraform {
  backend "s3" {
    bucket = "terraform-remote-state-bucket-312"
    # dynamodb_table = "erkin1593-terraform-remote-state-lock"
    key    = "artyterraform/tfstate.tfstate"
    region = "us-east-1"
  }
}
