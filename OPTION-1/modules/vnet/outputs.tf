output "vnet_id" {
  description = "The ID of the Virtual Network (VNET)."
  value       = azurerm_virtual_network.vnet.id
}

output "subnet_ids" {
  description = "A map of subnet names to their IDs."
  value       = { for k, v in azurerm_subnet.subnets : k => v.id }
}

output "nsg_ids" {
  description = "A map of NSG names to their IDs."
  value       = { for k, v in azurerm_network_security_group.nsg : k => v.id }
}

output "private_endpoint_ids" {
  description = "A map of private endpoint names to their IDs."
  value       = { for k, v in azurerm_private_endpoint.private_endpoint : k => v.id }
}