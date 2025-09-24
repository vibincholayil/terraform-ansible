variable "resource_group" {
  description = "Azure Resource Group"
  type        = string
  default     = "rg-team-a-dev"
}

variable "location" {
  description = "Azure Region"
  type        = string
  default     = "UK South"
}

variable "vm_admin_username" {
  description = "Admin username for VM"
  type        = string
  default     = "vibin"
}

variable "vm_admin_password" {
  description = "Admin password for VM"
  type        = string
  default     = "P@ssword123!"
}
