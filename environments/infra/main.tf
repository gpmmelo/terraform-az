module "rg" {
  source   = "../../modules/resource_group"
  name     = var.name
  location = var.location
  tags     = var.tags
}
module "network" {
  source              = "../../modules/network"
  resource_group_name = module.rg.resource_group_name
  location            = module.rg.resource_group_location
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  subnet_name         = var.subnet_name
  subnet_prefixes     = var.subnet_prefixes
  tags                = var.tags
}

module "vm" {
source = "../../modules/compute"
  vm_name              = var.vnet_name 
  name_public_ip       = var.name_public_ip 
  resource_group_name = module.rg.resource_group_name
  location            = module.rg.resource_group_location  
  public_ip_allocation = "Dynamic"
  nic_name             = var.nic_name 
  subnet_id            = module.network.subnet_id
  vnet_address_space    =  module.network.address_space
  subnet_address_prefix = module.network.subnet_prefixes
  nsg                  = var.nsg 
  vm_size              = var.vm_size 
  admin_username       = var.admin_username 
  admin_password       = var.admin_password 
  tags                = var.tags

}