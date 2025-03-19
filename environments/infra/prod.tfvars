#rg
name     = "rg-prod-infra"
location = "eastus"

#network
vnet_name       = "prod-vnet"
address_space   = ["172.0.0.0/16"]
subnet_name     = "prod-subnet"
subnet_prefixes = ["172.0.2.0/24"]
name_public_ip  = "prod-public-ip"

#compute
nic_name       = "prod-nic"
vm_name        = "prod-vm"
vm_size        = "Standard_F2"
admin_username = "adminuser"
nsg            = "my-nsg"
tags = {
  Project     = "Production"
  Owner       = "DevOps Team"
  Cost-Center = "department it"
  Environment = "prod"
}
