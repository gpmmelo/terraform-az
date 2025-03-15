#output "resource_group_name" {
#  description = "The name of the resource group for the backend."
#  value       = azurerm_resource_group.backend_rg.name
#}
output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "storage_account_id" {
  value = azurerm_storage_account.storage.id
}