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
module "compute" {
  source              = "../../modules/compute"
  nic_name            = "dev-nic"
  resource_group_name = module.rg.resource_group_name
  location            = module.rg.resource_group_location
  subnet_id           = module.network.subnet_id
  vm_name             = "dev-vm"
  vm_size             = "Standard_F2"
  admin_username      = "adminuser"
  public_key_path     = "~/.ssh/id_rsa.pub"
  tags                = var.tags
}
