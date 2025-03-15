
# Create a Resource Group for the backend
#resource "azurerm_resource_group" "backend_rg" {
#  name     = var.resource_group_name
#  location = var.location
#  tags     = var.tags
#}

# Create a Storage Account for the Terraform state
# Create a Storage Account for the Terraform state
resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version = "TLS1_2"

  tags = var.tags
}

# Create a Storage Container for the Terraform state
resource "azurerm_storage_container" "tfstate_container" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}