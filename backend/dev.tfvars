# Resource Group
resource_group_name    = "my-resource-group-dev"
location              = "East US"

# Storage Account
storage_account_name  = "mystorageaccountdev"
storage_container_name = "tfstate"

# Environment
environment           = "dev"

# Azure Credentials (from GitHub Secrets)
subscription_id       = ""
client_id             = ""
client_secret         = ""
tenant_id             = ""