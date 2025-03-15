locals {



# locals.tf

  # Environment-specific configurations
  environments = {
    dev = {
      resource_group_name = "rg-dev-example"
      location            = "East US"
      virtual_network_name = "vnet-dev-example"
      address_space       = ["10.1.0.0/16"]
      subnets = [
        {
          name           = "subnet-dev-1"
          address_prefix = "10.1.1.0/24"
        },
        {
          name           = "subnet-dev-2"
          address_prefix = "10.1.2.0/24"
        }
      ]
    },
    prod = {
      resource_group_name = "rg-prod-example"
      location            = "West US"
      virtual_network_name = "vnet-prod-example"
      address_space       = ["10.2.0.0/16"]
      subnets = [
        {
          name           = "subnet-prod-1"
          address_prefix = "10.2.1.0/24"
        },
        {
          name           = "subnet-prod-2"
          address_prefix = "10.2.2.0/24"
        }
      ]
    }
  }

  tags-dev = {
    Project     = "developer"
    Owner       = "DevOps Team"
    Cost-Center = "department it"
    Environment = "dev"
  }
  tags-prod = {
    Project     = "developer"
    Owner       = "DevOps Team"
    Cost-Center = "department it"
    Environment = "prod"
  }



  # Select the environment based on a variable
  env = var.environment


}