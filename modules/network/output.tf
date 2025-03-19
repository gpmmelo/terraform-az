output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = azurerm_subnet.subnet.id
}


output "subnet_prefixes" {
  description = "The address prefixes of the subnet"
  value       = azurerm_subnet.subnet.address_prefixes
}

output "address_space" {
  description = "The address space of the virtual network"
  value       = azurerm_virtual_network.vnet.address_space
}