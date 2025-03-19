#rg
name     = "rg-dev-infra"
location = "eastus"


#network
vnet_name       = "dev-vnet"
address_space   = ["10.0.0.0/16"]
subnet_name     = "dev-subnet"
subnet_prefixes = ["10.0.2.0/24"]
name_public_ip  = "dev-public-ip"


#compute
nic_name       = "dev-nic"
vm_name        = "dev-vm"
vm_size        = "Standard_F2"
admin_username = "adminuser"
nsg            = "my-nsg"
tags = {
  Project     = "developer"
  Owner       = "DevOps Team"
  Cost-Center = "department it"
  Environment = "dev"
}
