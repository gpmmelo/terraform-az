#module "avm-res-network-virtualnetwork" {
#  source = "Azure/avm-res-network-virtualnetwork/azurerm"
#
#  address_space       = ["10.0.0.0/16"]
#  location            = "East US"
#  name                = "myVNet"
#  resource_group_name = "myResourceGroup"
#  subnets = {
#    "subnet1" = {
#      name             = "subnet1"
#      address_prefixes = ["10.0.0.0/24"]
#    }
#    "subnet2" = {
#      name             = "subnet2"
#      address_prefixes = ["10.0.1.0/24"]
#    }
#  }
#}


resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = "example-machine"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

resource "azurerm_storage_account" "storage" {
  name                     = "devasd12312344"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version = "TLS1_2"

}


# Create a Storage Container for the Terraform state
resource "azurerm_storage_container" "tfstate_container" {
  name                  = "containertfstate"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}