# AWS Environment Provisioning and Configuration with Terraform & Ansible

## Usecase Overview

This usecase demonstrates how to provision an AWS environment using **Terraform** and configure it using **Ansible**.  

---

## Part 1: Provision AWS Resources Using Terraform

- **Resources Created:**
  - A **VPC**
  - An **EC2 instance**
  - A **security group** (using dynamic block)

- **Tags Applied to Each Resource:**
  - `Env = Dev`
  - `costPlan = 1y`
  - `Owner = Terraform`

- **Actions Performed:**
  - Provision the resources using Terraform
  - Destroy all resources when no longer needed

---

## Part 2: Modular Terraform Code and Configuration with Ansible

- Created reusable modules for:
  - **VPC**
  - **EC2**
  - **Security Group**

- **Outputs:**
  - Private IP of the EC2 instance
  - VPC ID

- **Objective:**
  - Reduce code duplication
  - Make infrastructure scalable and maintainable


1. **Install packages using Ansible**
   - Nginx
   - Git

2. **Create a new user:**
   - Username: Your own name
   - Ensures a home directory is created
   - Assigns `/bin/bash` as the default shell

---

## Project Structure



Ansible install on master server: 
sudo apt update
sudo apt install ansible
ssh enable:
creaste keypair: ssh-keygen -t ed25519
ssh copy id: ssh-copy-id -i /home/vibin/.ssh/id_ed25519.pub ec2-user@18.144.169.161
enter to ec2 server without password: ssh ec2-user@18.144.169.161
ansible --version: ansible 2.9.6

created inventory file: with the server ip

