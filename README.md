# AWS Environment Provisioning and Configuration with Terraform & Ansible

## Usecase Overview

This usecase demonstrates how to provision an AWS environment using **Terraform** and configure it using **Ansible**.  

---

## Part 1: Provision AWS Resources Using Terraform (AWS-environment)

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
  ![Provision the resources using Terraform](https://github.com/vibincholayil/terraform-ansible-project/blob/master/images/ss_1_1.png)
  - Destroy all resources when no longer needed
  ![Destroy all resources when no longer needed](https://github.com/vibincholayil/terraform-ansible-project/blob/master/images/ss_1_2.png)

---

## Part 2: Modular Terraform Code and Configuration with Ansible (AWS-env-module)

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

For experimenting the ansible i have created my linux server as my ansible server and the new ec2 insted created as my ansible host server
so i have installed ansible in my own linux system 

sudo apt update
so install ansible -y

generate and copy the ssh key to the ec2 server
ssh-keygen -t ed25519
ssh-copy-id i ~/vibin/.ssh/id_ed25519 18.144.169.161
![keygen](https://github.com/vibincholayil/terraform-ansible-project/blob/master/images/ss_2_2.png)
created a inventry.ini file in the ansible server and provide the host ip
check it can connect or not.
![ping](https://github.com/vibincholayil/terraform-ansible-project/blob/master/images/ss_2_3.png)


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

