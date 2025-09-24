provider "azurerm" {
  features {}   # Required block for AzureRM provider
  subscription_id = "your-subscription-id"  # Optional if using environment auth
  tenant_id       = "your-tenant-id"        # Optional if using environment auth
}
