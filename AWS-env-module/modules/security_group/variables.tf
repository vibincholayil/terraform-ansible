variable "sg_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ingress_ports" {
  type = list(number)
}
