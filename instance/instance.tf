variable "key_name" {}

variable "subnet_id" {}

variable "sg_id" {}
#create instance with key_name
resource "aws_instance" "web" {
  ami                    = "ami-08f3d892de259504d"
  instance_type          = "t2.micro"
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.sg_id
  #   user_data = << EOF
  # #! /bin/bash
  # sudo yum update -y
  # wget https://wordpress.org/latest.tar.gz
  # tar -xzf latest.tar.gz
  # sudo systemctl start mariadb
  # sudo service mysqld start
  #   EOF

  tags = {
    Name = "wordpress-ec2"
  }
}
