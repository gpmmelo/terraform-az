output "vnet_id" {
  description = "ID of the virtual network"
  value       = module.network.vnet_id
}
output "subnet_id" {
  value = module.network.subnet_id
}