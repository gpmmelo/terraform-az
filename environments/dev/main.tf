locals {
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



  
}


module "resource_group" {
  source = "../modules/resource_group"
  name = "rg-dev"
  tags = "env = dev"
}
module "avm-res-network-virtualnetwork" {
  source = "../modules/vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "East US"
  name                = "myVNet"
  resource_group_name = module.resource_group.name
  subnets = {
    "subnet1" = {
      name             = "subnet1"
      address_prefixes = ["10.0.0.0/24"]
    }
    "subnet2" = {
      name             = "subnet2"
      address_prefixes = ["10.0.1.0/24"]
    }
  }
}

module "vm-linux" {
  source = "../modules/vm-linux"

  vnet                = "aseu001-infrastructure-vnet"
  subnet              = "aseu001-infrastructure-subnet"
  location            = "Germany West Central"
  subscription_id     = "f7a588d3-3b47-411b-944c-21ba2f99ad97"
  resource_group_name = "rg-aseu001-service-prd"
  ip_address          = "172.21.32.12"
  name                = "aseu001invp006"
  vm_size             = "Standard_B2s"
  zone                = "1"
  bootdisk_type       = "StandardSSD_LRS"
  bootdisk_size       = 60
  
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {
    displayname        = "aseu001invp006"
    area               = "SOC"
    environment        = "prd"
    sla                = "24x7"
    role               = "Qradar DLC"
    technicalowner     = "C&C"
    compliance         = "gxp"
    dataclassification = "confidential"
  }
}