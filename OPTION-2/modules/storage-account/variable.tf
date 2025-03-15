variable "resource_group_name" {
  description = "The name of the resource group for the backend."
  type        = string
  #default     = "tfstate-rg"
}
variable "location" {
  description = "The Azure region where the backend resources will be deployed."
  type        = string
  #default     = "East US"
}
variable "storage_account_name" {
  description = "The name of the storage account for the Terraform state."
  type        = string
  #default     = "bah1234test1234"
}
variable "storage_container_name" {
  description = "The name of the storage container for the Terraform state."
  type        = string
  #default     = "tfstate"
}
variable "tags" {
  description = "Tags to apply to the backend resources."
  type        = map(string)
  #default = {
  #  environment = "backend"
  #  managed_by  = "terraform"
  #}
}
