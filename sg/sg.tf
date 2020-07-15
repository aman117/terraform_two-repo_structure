#variable
variable "vpc_id" {}

variable "ingress" {
  type    = list(number)
  default = [22, 443, 80]
}
variable "egress" {
  type    = list(number)
  default = [22, 443, 80]
}

#create sg
resource "aws_security_group" "wordpress-sg" {
  name   = "Allow HTTPS"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  dynamic "egress" {
    iterator = port
    for_each = var.egress
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = "wordpress-sg"
  }
}

#outputs
output "sg_id" {
  value = [aws_security_group.wordpress-sg.id]
}

# output "sg_rules_output" {
#   value = [for i in var.ingress : "PORT i this ports are open and confirmed"]
# }
