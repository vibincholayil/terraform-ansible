variable "ami_id" {
    description = "ami-0444794b421ec32e4"
    type        = string
}
variable "instance_type" {}
variable "subnet_id" {}
variable "sg_id" {}
variable "tags" {
  type = map(string)
}
