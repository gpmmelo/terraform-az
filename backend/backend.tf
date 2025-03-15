locals {
  tags 


}

module "resource_group" {
  source = "../modules/resource_group"
  name = "rg-dev"
  tags = "env = dev"
}

module "backend" {
  source = "../modules/storage-account"

  resource_group_name    = module.resource_group.resource_group_name.name
  location              = "East US"
  storage_account_name  = "devenvtfstatestorage"
  storage_container_name = "tfstate"
  tags = {
    environment = "backend"
    managed_by  = "terraform"
  }
}
output "backend_outputs" {
  value = module.backend
}