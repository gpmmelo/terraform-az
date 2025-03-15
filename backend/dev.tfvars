# Resource Group
resource_group_name    = "my-resource-group-dev"
location              = "East US"

# Storage Account
storage_account_name  = "mystorageaccountdev"
storage_container_name = "tfstate"

# Environment
environment           = "dev"

# Azure Credentials (from GitHub Secrets)
subscription_id       = "${{ secrets.ARM_SUBSCRIPTION_ID }}"
client_id             = "${{ secrets.ARM_CLIENT_ID }}"
client_secret         = "${{ secrets.ARM_CLIENT_SECRET }}"
tenant_id             = "${{ secrets.ARM_TENANT_ID }}"