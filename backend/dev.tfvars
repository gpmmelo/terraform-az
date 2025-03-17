# Resource Group
resource_group_name = "my-resource-group-dev"
location            = "East US"

# Storage Account
storage_account_name   = "1234556mystorageacc"
storage_container_name = "tfstate"

# Environment
environment = "dev"

tags = {
  Project     = "developer"
  Owner       = "DevOps Team"
  Cost-Center = "department it"
  Environment = "dev"
}
