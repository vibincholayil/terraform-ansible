output "vm_private_ip" {
  description = "Private IP of the VM"
  value       = azurerm_network_interface.main.private_ip_address
}

output "vm_public_ip" {
  description = "Public IP of the VM"
  value       = azurerm_public_ip.main.ip_address
}

output "vnet_id" {
  description = "VNet ID"
  value       = azurerm_virtual_network.main.id
}
