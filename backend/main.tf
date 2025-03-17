module "resource_group" {
  source   = "../modules/resource_group"
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}
module "storage_account" {
  source = "../modules/storage-account"

  resource_group_name    = module.resource_group.resource_group_name
  location               = module.resource_group.resource_group_location
  storage_account_name   = var.storage_account_name
  storage_container_name = var.storage_container_name
  tags                   = var.tags
}
