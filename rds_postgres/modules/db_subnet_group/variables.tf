variable "db_sg_gr_name" {
  description = "Creates a unique name for RDS Subnet Group"
  type        = string
}

variable "subnet_ids" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
  default     = []
}