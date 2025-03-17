output "storage_account_id" {
  description = "ID of the storage account"
  value       = azurerm_storage_account.storage.id
}

output "container_id" {
  description = "ID of the storage container"
  value       = azurerm_storage_container.tfstate_container.id
}