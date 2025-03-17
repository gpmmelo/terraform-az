terraform {
  backend "azurerm" {
    resource_group_name  = "dev-resources"         # Resource group where storage account exists
    storage_account_name = "devstatefile123456"    # Storage account name
    container_name       = "dev-tfstate"           # Container name
    key                  = "dev.terraform.tfstate" # State file name for dev environment
  }
}
