provider "aws" {
  region = "eu-central-1"
}

variable "tags" {
  default = {
    Env      = "Dev"
    costPlan = "1y"
    Owner    = "Terraform"
  }
}

module "vpc" {
  source      = "./modules/vpc"
  cidr_block  = "10.0.0.0/16"
  subnet_cidr = "10.0.1.0/24"
  tags        = var.tags
}

module "security_group" {
  source        = "./modules/security_group"
  sg_name       = "web-sg"
  vpc_id        = module.vpc.vpc_id
  ingress_ports = [22, 80, 443]
  tags          = var.tags
}

module "ec2" {
  source        = "./modules/ec2"
  ami_id        = "ami-02ff57195b457bd9a"
  instance_type = "t2.micro"
  subnet_id     = module.vpc.subnet_id
  sg_id         = module.security_group.sg_id
  tags          = var.tags
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "ec2_private_ip" {
  value = module.ec2.private_ip
}

