variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
}

variable "container_name" {
  description = "Name of the storage container"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}