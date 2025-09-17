resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.sg_id]
  associate_public_ip_address = true
  key_name      = var.key_name 
  tags = {
    Name = var.Name         
  }
}

output "private_ip" {
  value = aws_instance.this.private_ip
}
