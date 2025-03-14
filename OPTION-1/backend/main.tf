provider "azurerm" {
  features {}
    subscription_id = "dcb704e1-b807-4206-b060-767cfffe8fff"

}

resource "azurerm_resource_group" "backend_rg" {
  name     = "tfstate-rg"
  location = "East US"
  tags = {
    environment = "backend"
  }
}

resource "azurerm_storage_account" "tfstate_storage" {
  name                     = "tfstatestorage"
  resource_group_name      = azurerm_resource_group.backend_rg.name
  location                 = azurerm_resource_group.backend_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version           = "TLS1_2"

  tags = {
    environment = "backend"
  }
}

resource "azurerm_storage_container" "tfstate_container" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate_storage.name
  container_access_type = "private"
}