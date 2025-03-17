# Resource Group
resource_group_name = "my-resource-group-prod"
location            = "East US"

# Storage Account
storage_account_name   = "mystorageaccountprod"
storage_container_name = "tfstateprod"

# Environment
environment = "prod"
tags = {
  Project     = "production"
  Owner       = "DevOps Team"
  Cost-Center = "department it"
  Environment = "prod"
}