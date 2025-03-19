#sub
variable "subscription_id" {}

#rg
variable "name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region where the resource group will be deployed."
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

#storage
variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}
variable "container_name" {
  description = "Name of the storage container"
  type        = string
}
