
data "azurerm_resource_group" "rg" {
  name = "dev-resources"
}

data "resource_group_location" "location" {
  location = "East US"
}

module "network" {
  source              = "../../modules/network"
  vnet_name           = "dev-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = data.resource_group_location.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_name         = "dev-subnet"
  subnet_prefixes     = ["10.0.2.0/24"]
  tags                = var.tags
}
module "compute" {
  source              = "../../modules/compute"
  nic_name            = "dev-nic"
  location            = data.resource_group_location.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = module.network.subnet_id
  vm_name             = "dev-vm"
  vm_size             = "Standard_F2"
  admin_username      = "adminuser"
  public_key_path     = "~/.ssh/id_rsa.pub"
  tags                = var.tags
}

module "storage" {
  source               = "../../modules/storage"
  storage_account_name = "devstorage12345"
  resource_group_name  = data.azurerm_resource_group.rg.name
  location             = data.resource_group_location.rg.location
  container_name       = "dev-tfstate"
  tags                 = var.tags
}
