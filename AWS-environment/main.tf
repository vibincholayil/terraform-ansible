# VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name     = "vibin_demo_vpc"
    Env      = "Dev"
    costPlan = "1y"
    Owner    = "Terraform"
  }
}

# Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name     = "vibin_demo_subnet"
    Env      = "Dev"
    costPlan = "1y"
    Owner    = "Terraform"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name     = "vibin_demo_igw"
    Env      = "Dev"
    costPlan = "1y"
    Owner    = "Terraform"
  }
}

# Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name     = "vibin_demo_rt"
    Env      = "Dev"
    costPlan = "1y"
    Owner    = "Terraform"
  }
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Security Group with dynamic block
resource "aws_security_group" "web_sg" {
  name   = "vibin_demo_sg"
  vpc_id = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Env      = "Dev"
    costPlan = "1y"
    Owner    = "Terraform"
  }
}

# EC2 Instance
resource "aws_instance" "web" {
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  tags = {
    Name     = "vibin_demo_instance"
    Env      = "Dev"
    costPlan = "1y"
    Owner    = "Terraform"
  }
}
