provider "aws" {
  region = "us-west-1"
}

module "vpc" {
  source      = "./modules/vpc"
  cidr_block  = "10.0.0.0/16"
  subnet_cidr = "10.0.1.0/24"
}

module "security_group" {
  source        = "./modules/security_group"
  sg_name       = "vibin-sg"
  vpc_id        = module.vpc.vpc_id
  ingress_ports = [22, 80, 443]
}

module "ec2" {
  source        = "./modules/ec2"
  ami_id        = "ami-00142eb1747a493d9" 
  instance_type = "t2.micro"
  subnet_id     = module.vpc.subnet_id
  sg_id         = module.security_group.sg_id
}
