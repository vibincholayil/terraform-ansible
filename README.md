# AWS Environment Provisioning and Configuration with Terraform & Ansible
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
so i have installed ansible in my own linux system Ansible install on master server: 

sudo apt update
so install ansible -y
ansible --version: ansible 2.9.6


generate and copy the ssh key to the ec2 server
ssh-keygen -t ed25519
ssh-copy-id i ~/vibin/.ssh/id_ed25519 18.144.169.161
![keygen](https://github.com/vibincholayil/terraform-ansible-project/blob/master/images/ss_2_1.png)
created a inventry.ini file in the ansible server and provide the host ip
enter to ec2 server without password

check it can connect or not.
![ping](https://github.com/vibincholayil/terraform-ansible-project/blob/master/images/ss_2_2.png)

1. **Install packages using Ansible**
   - Nginx
   - Git

2. **Create a new user:**
   - Username: Your own name
   - Ensures a home directory is created
   - Assigns `/bin/bash` as the default shell


after confirming the connection is working i create a ansible playbook in the ansible server called setup-ec2 and mentioned install nginx, git and add Create new user 'vibin'
![playbook](https://github.com/vibincholayil/terraform-ansible-project/blob/master/images/ss_2_3.png)


# AWS Environment Provisioning and Configuration with Terraform & Ansible

## Use Case Overview

This project demonstrates how to provision an AWS environment using **Terraform** and configure it using **Ansible**.  

---

## Part 1: Provision AWS Resources Using Terraform (`AWS-environment`)

**Resources Created:**
- VPC
- EC2 instance
- Security Group

**Tags Applied to Each Resource:**
- Env = Dev
- costPlan = 1y
- Owner = Terraform

**Actions Performed:**
- Provision resources using Terraform    
  ![Provision resources](https://github.com/vibincholayil/terraform-ansible-project/blob/master/images/ss_1_1.png)

- Destroy all resources when no longer needed  
  ![Destroy resources](https://github.com/vibincholayil/terraform-ansible-project/blob/master/images/ss_1_2.png)

---

## Part 2: Modular Terraform Code and Configuration with Ansible (`AWS-env-module`)

**Modules Created:**
- VPC  
- EC2  
- Security Group

**Outputs:**
- Private IP of the EC2 instance
- VPC ID

**Objectives:**
- Reduce code duplication
- Make the infrastructure scalable and maintainable

---

### Ansible Configuration

For experimenting with Ansible, I used my local Linux machine as the **Ansible control node** and the newly created EC2 instance as the **Ansible host**.  

**Install Ansible on the control node:**

   ```bash
   sudo apt update
   sudo apt install ansible -y
   ansible --version   # ansible 2.9.6
```

**Generate and copy SSH keys to the EC2 host:**

   ```bash
  ssh-keygen -t ed25519
  ssh-copy-id -i ~/vibin/.ssh/id_ed25519 18.144.169.161
```
  ![keygen](https://github.com/vibincholayil/terraform-ansible-project/blob/master/images/ss_2_1.png)  

**Create an inventory.ini file on the Ansible server and provide the EC2 host IP.**

Test connectivity:  
```bash
ansible -i inventory.ini all -m ping
```
  ![ping](https://github.com/vibincholayil/terraform-ansible-project/blob/master/images/ss_2_2.png)  

**Ansible Playbook: setup-ec2.yml**

After confirming connectivity, I created an Ansible playbook (setup-ec2.yml) that performs the following tasks:  

Install packages:Nginx, Git  
Create a new use - Username: vibin  
Ensures a home directory is created then Assigns /bin/bash as the default shell  

Example playbook execution:
  ![playbook](https://github.com/vibincholayil/terraform-ansible-project/blob/master/images/ss_2_3.png)  

## Conclusion  

This usecase successfully demonstrates the end-to-end process of provisioning and configuring an AWS environment using **Terraform** and **Ansible**.  

- **Terraform** ensured that the infrastructure was created in a consistent, reusable, and modular way.  
- **Ansible** automated the configuration of the EC2 instance, including package installations and user creation.  
- By combining these tools, the workflow becomes **scalable, maintainable, and efficient**, reducing manual effort and potential human errors.  

This approach can be extended to larger environments, multiple services, and production-grade deployments, making it a strong foundation for **Infrastructure as Code (IaC)** and **Configuration Management** practices.  
