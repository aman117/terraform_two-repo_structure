variable "instance_type" {}
variable "instance_type2" {}

variable "avz" {}

variable "desired_capacity" {}

variable "max_size" {}

variable "min_size" {}

variable "health_check_type" {}

variable "on_demand_base_capacity" {}

variable "on_demand_percentage_above_base_capacity" {}

variable "spot_allocation_strategy" {}

variable "spot_instance_pools" {}

variable "spot_max_price" {
  default = ""
}

variable "name" {}


variable "image_id" {}

variable "sg_id" {}

variable "subnet_id" {}
