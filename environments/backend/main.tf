resource "azurerm_resource_group" "rg" {
  name     = "dev-resources"
  location = "East US"
  tags     = var.tags
}

module "storage" {
  source               = "../../modules/storage"
  storage_account_name = "devstatefile123456"
  resource_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
  container_name       = "dev-tfstate"
  tags                 = var.tags
}
