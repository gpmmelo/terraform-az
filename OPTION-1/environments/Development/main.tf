module "vnet" {
  source              = "./modules/vnet"
  vnet_name           = "my-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "East US"
  resource_group_name = "my-rg"

  subnets = {
    "subnet1" = {
      address_prefixes = ["10.0.1.0/24"]
    }
  }

  nsgs = {
    "nsg1" = {
      rules = [
        {
          name                       = "AllowSSH"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "22"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    }
  }
}