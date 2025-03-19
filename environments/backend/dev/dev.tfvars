#rg
name     = "rg-dev"
location = "eastus"

tags = {
  Project     = "developer"
  Owner       = "DevOps Team"
  Cost-Center = "department it"
  Environment = "dev"
}

#storage
storage_account_name = "devstatefile123456"    # Storage account name
container_name       = "dev-tfstate"           # Container name
key                  = "dev.terraform.tfstate" # State file name for dev environment