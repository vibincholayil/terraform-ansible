provider "aws" {
  region = "eu-central-1"
}

module "vpc" {
  source      = "./modules/vpc"
  cidr_block  = "10.0.0.0/16"
  subnet_cidr = "10.0.1.0/24"
}

module "security_group" {
  source        = "./modules/security_group"
  sg_name       = "web-sg"
  vpc_id        = module.vpc.vpc_id
  ingress_ports = [22, 80, 443]
}

module "ec2" {
  source        = "./modules/ec2"
  ami_id        = "ami-0444794b421ec32e4"
  instance_type = "t2.micro"
  subnet_id     = module.vpc.subnet_id
  sg_id         = module.security_group.sg_id
}
