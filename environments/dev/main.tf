module "resource_group" {
  source = "../../modules/resource_group"
  name = "rg-dev"
  tags = "env = dev"
}



module "avm-res-network-virtualnetwork" {
  source = "../../modules/vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "East US"
  name                = "myVNet"
  resource_group_name = module.resource_group.name
  subnets = {
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

