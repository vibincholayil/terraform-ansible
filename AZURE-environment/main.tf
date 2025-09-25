provider "azurerm" {
  features {}
  subscription_id = "3a72be92-287b-4f1e-840a-5e3e71100139"
}

# -----------------------
# Resource Group
# -----------------------
resource "azurerm_resource_group" "rg-team-a1" {
  name     = "team-a-rg"
  location = "East US"

  tags = {
    Env      = "Dev"
    costPlan = "1y"
    Owner    = "Terraform"
  }
}

# -----------------------
# Virtual Network
# -----------------------
resource "azurerm_virtual_network" "vnet" {
  name                = "team-a-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg-team-a1.location
  resource_group_name = azurerm_resource_group.rg-team-a1.name

  tags = {
    Env      = "Dev"
    costPlan = "1y"
    Owner    = "Terraform"
  }
}

# -----------------------
# Subnet
# -----------------------

resource "azurerm_subnet" "subnet" {
  name                 = "team-a-subnet"
  resource_group_name  = azurerm_resource_group.rg-team-a1.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_assoc" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# -----------------------
# Network Security Group with SSH & HTTP
# -----------------------
variable "nsg_rules" {
  default = [
    {
      name                       = "SSH"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range           = "*"
      destination_port_range      = "22"
      source_address_prefix       = "*"
      destination_address_prefix  = "*"
    },
    {
      name                       = "HTTP"
      priority                   = 200
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range           = "*"
      destination_port_range      = "80"
      source_address_prefix       = "*"
      destination_address_prefix  = "*"
    }
  ]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "team-a-nsg"
  location            = azurerm_resource_group.rg-team-a1.location
  resource_group_name = azurerm_resource_group.rg-team-a1.name

  dynamic "security_rule" {
    for_each = var.nsg_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }

  tags = {
    Env      = "Dev"
    costPlan = "1y"
    Owner    = "Terraform"
  }
}

# -----------------------
# Public IP
# -----------------------
resource "azurerm_public_ip" "vm_ip" {
  name                = "team-a-vm-ip"
  resource_group_name = azurerm_resource_group.rg-team-a1.name
  location            = azurerm_resource_group.rg-team-a1.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

# -----------------------
# NIC
# -----------------------
resource "azurerm_network_interface" "nic" {
  name                = "team-a-nic"
  location            = azurerm_resource_group.rg-team-a1.location
  resource_group_name = azurerm_resource_group.rg-team-a1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_ip.id
  }


  tags = {
    Env      = "Dev"
    costPlan = "1y"
    Owner    = "Terraform"
  }
}

# -----------------------
# Linux VM
# -----------------------
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "team-a-vm"
  resource_group_name = azurerm_resource_group.rg-team-a1.name
  location            = azurerm_resource_group.rg-team-a1.location
  size                = "Standard_B1s"
  admin_username      = "azureuser"

  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  tags = {
    Env      = "Dev"
    costPlan = "1y"
    Owner    = "Terraform"
  }
}

# -----------------------
# Outputs
# -----------------------
output "private_ip" {
  value = azurerm_network_interface.nic.private_ip_address
}

output "public_ip" {
  value = azurerm_public_ip.vm_ip.ip_address
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}
