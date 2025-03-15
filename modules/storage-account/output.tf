#output "resource_group_name" {
#  description = "The name of the resource group for the backend."
#  value       = azurerm_resource_group.backend_rg.name
#}

output "storage_account_name" {
  description = "The name of the storage account for the Terraform state."
  value       = azurerm_storage_account.tfstate_storage.name
}

output "storage_container_name" {
  description = "The name of the storage container for the Terraform state."
  value       = azurerm_storage_container.tfstate_container.name
}

output "storage_account_id" {
  description = "The ID of the storage account for the Terraform state."
  value       = azurerm_storage_account.tfstate_storage.id
}