output "vpc_id" {
  value = module.vpc.vpc_id
}

output "ec2_private_ip" {
  value = module.ec2.private_ip
}
