# Azure VM image (using a Marketplace image reference)
variable "vm_image" {
  description = "Azure VM image details (publisher, offer, sku, version)"
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "Canonical"  # Ubuntu
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}

# Ingress ports for NSG rules
variable "ingress_ports" {
  description = "List of ingress ports for Network Security Group"
  type        = list(number)
  default     = [22, 80, 443] # SSH, HTTP, HTTPS
}
