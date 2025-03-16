# Resource Group
resource_group_name    = "my-resource-group-dev"
location              = "East US"

# Storage Account
storage_account_name  = "1234556mystorageaccountdev"
storage_container_name = "tfstate"

# Environment
environment           = "dev"

# Azure Credentials (from GitHub Secrets)
client_id             = "${{ secrets.AZURE_CLIENT_ID }}"
client_secret         = "${{ secrets.ARM_CLIENT_SECRET }}"
subscription_id       = "${{secrets.AZURE_SUBSCRIPTION_ID}}"
tenant_id             = "${{ secrets.AZURE_TENANT_ID }}"
tags= {
    Project     = "developer"
    Owner       = "DevOps Team"
    Cost-Center = "department it"
    Environment = "dev"
  }
