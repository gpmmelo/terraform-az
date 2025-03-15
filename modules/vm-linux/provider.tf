terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.1"
    }
  }
}
provider "azurerm" {
  features {}

  #subscription_id = var.subscription_id
  #tenant_id         = "<azure_subscription_tenant_id>"
  #client_id         = "<rg-aseu001-service-prd_principal_appid>"
  #client_secret     = "<rg-aseu001-service-prd_principal_password>"
}
