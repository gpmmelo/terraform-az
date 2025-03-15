output "vnet_id" {
  description = "The ID of the created Virtual Network."
  value       = module.vnet.vnet_id
}

output "vnet_name" {
  description = "The name of the created Virtual Network."
  value       = module.vnet.vnet_name
}

output "subnet_ids" {
  description = "The IDs of the created subnets."
  value       = module.vnet.subnet_ids
}

output "subnet_names" {
  description = "The names of the created subnets."
  value       = module.vnet.subnet_names
}