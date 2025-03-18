#sub
subscription_id = "dcb704e1-b807-4206-b060-767cfffe8fff"

#rg
name     = "rg-prod"
location = "eastus"

tags = {
  Project     = "prodeloper"
  Owner       = "DevOps Team"
  Cost-Center = "department it"
  Environment = "prod"
}

#storage
    storage_account_name = "prodstatefile123456"    # Storage account name
    container_name       = "prod-tfstate"           # Container name
    key                  = "prod.terraform.tfstate" # State file name for dev environment