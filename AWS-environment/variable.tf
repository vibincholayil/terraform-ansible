variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-02ff57195b457bd9a" # update for your region
}

variable "ingress_ports" {
  description = "List of ingress ports"
  type        = list(number)
  default     = [22, 80, 443] # SSH, HTTP, HTTPS
}
