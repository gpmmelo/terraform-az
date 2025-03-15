module "vnet" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.8.1"

  address_space       = var.address_space
  location            = var.location
  name                = var.vnet_name
  resource_group_name = module.resource_group.resource_group_name.name
  subnets             = var.subnet_names
  tags                = var.tags
}