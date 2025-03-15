environment = "dev"
resource_group_name    = "rg-dev"
location              = "East US"
storage_account_name  = "bah123456mystorageaccount"
storage_container_name = "devtfstate"
  tags = {
    Project     = "developer"
    Owner       = "DevOps Team"
    Cost-Center = "department it"
    Environment = "dev"
  }