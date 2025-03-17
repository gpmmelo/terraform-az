#sub
subscription_id = "dcb704e1-b807-4206-b060-767cfffe8fff"

#rg
resource_group_name = "rg-prod"
location            = "eastus"

tags = {
  Project     = "developer"
  Owner       = "DevOps Team"
  Cost-Center = "department it"
  Environment = "prod"
}

#network
vnet_name       = "prod-vnet"
address_space   = ["10.0.0.3/16"]
subnet_name     = "prod-subnet"
subnet_prefixes = ["10.0.3.0/24"]

#compute
nic_name        = "prod-nic"
vm_name         = "prod-vm"
vm_size         = "Standard_F2"
admin_username  = "adminuser"
public_key_path = "~/.ssh/id_rsa.pub"