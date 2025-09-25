# AWS Environment Provisioning and Configuration with Terraform & Ansible
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

**Actions**
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

 - Install packages:Nginx, Git  
 - Create a new use - Username: vibin  
 - Ensures a home directory is created then Assigns /bin/bash as the default shell  

Example playbook execution:
  ![playbook](https://github.com/vibincholayil/terraform-ansible-project/blob/master/images/ss_2_3.png)  


# Azure Infrastructure Provisioning & Configuration with Terraform & Ansible   
This project demonstrates how to **provision an Azure environment using Terraform** and then **configure the deployed VM using Ansible**.  

## Infrastructure Provisioned with Terraform  
- **Resource Group** → `team-a-rg`  
- **Virtual Network (VNet)** → `team-a-vnet (10.0.0.0/16)`  
- **Subnet** → `team-a-subnet (10.0.1.0/24)`  
- **Network Security Group (NSG)** → Allows **SSH (22)** & **HTTP (80)**  
- **Public IP** → Static allocation for VM  
- **Network Interface (NIC)** → Connected to Subnet + Public IP  
- **Linux Virtual Machine** → Ubuntu 20.04 LTS (`Standard_B1s`)  
  - Admin user: `azureuser`  
  - SSH Key Authentication enabled  
  - Canonical Ubuntu Image  

### Terraform Outputs  
- **Private IP** of VM  
- **Public IP** of VM  
- **VNet ID**  

## Configuration with Ansible  
After Terraform provisions the VM, Ansible connects over SSH and configures it:  

### Playbook: **User Management**  
- Creates a new user **Team-A** with:  
  - Home directory  
  - Bash shell  

### Playbook: **Package Installation**  
- Updates package cache  
- Installs common packages:  
  - `nginx` (web server)  
  - `git` (version control)  
  - `htop` (process monitoring)  
  - `curl` (network tool)  

![ping](https://github.com/vibincholayil/terraform-ansible-project/blob/master/images/az_tf_1.png)  
![ping](https://github.com/vibincholayil/terraform-ansible-project/blob/master/images/az_tf_2.png)  


## Conclusion  

This usecase successfully demonstrates the end-to-end process of provisioning and configuring an AWS environment using **Terraform** and **Ansible**.  

- **Terraform** ensured that the infrastructure was created in a consistent, reusable, and modular way.  
- **Ansible** automated the configuration of the EC2 instance, including package installations and user creation.  
- By combining these tools, the workflow becomes **scalable, maintainable, and efficient**, reducing manual effort and potential human errors.  

This approach can be extended to larger environments, multiple services, and production-grade deployments, making it a strong foundation for **Infrastructure as Code (IaC)** and **Configuration Management** practices.  
