module "avm-res-network-virtualnetwork" {
  source = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.8.1"
  address_space       = ["10.0.0.0/16"]
  location            = "East US"
  name                = "myVNet"
  resource_group_name = module.resource_group_name.resource_group.name
    "subnet1" = {
      name             = "subnet1"
      address_prefixes = ["10.0.0.0/24"]
    }
    "subnet2" = {
      name             = "subnet2"
      address_prefixes = ["10.0.1.0/24"]
    }
  }
}