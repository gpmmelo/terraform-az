#terraform {
#  required_providers {
#    azurerm = {
#      source  = "hashicorp/azurerm"
#      version = "=4.1.0"
#    }
#  }
#}

#Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  #subscription_id = "dcb704e1-b807-4206-b060-767cfffe8fff"
  subscription_id = var.subscription_id
  #client_id       = var.client_id
  #client_secret   = var.client_secret
  #tenant_id       = var.tenant_id
}
