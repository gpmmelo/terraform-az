module "rg" {
  source   = "../../modules/resource_group"
  name     = var.name
  location = var.location
  tags     = var.tags
}
module "storage" {
  source               = "../../modules/storage"
  storage_account_name = var.storage_account_name
  resource_group_name  = module.rg.resource_group_name
  location             = module.rg.resource_group_location
  container_name       = var.container_name
  tags                 = var.tags
}
