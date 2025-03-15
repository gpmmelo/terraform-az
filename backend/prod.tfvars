resource_group_name    = "rg-prod"
location              = "East US"
storage_account_name  = "1234prodmystorageaccount"
storage_container_name = "prodtfstate"
  tags = {
    Project     = "developer"
    Owner       = "DevOps Team"
    Cost-Center = "department it"
    Environment = "prod"
  }