output "vnet_id" {
  description = "The ID of the Virtual Network (VNet)"
  value       = azurerm_virtual_network.main.id
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = azurerm_subnet.public.id
}

output "vm_public_ip" {
  description = "Public IP of the Azure VM"
  value       = azurerm_public_ip.web_ip.ip_address
}
