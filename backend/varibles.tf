variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account."
  type        = string
}

variable "storage_container_name" {
  description = "The name of the storage container."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the resources."
  type        = map(string)
  default     = {}
}
variable "environment" {
  description = "The environment (dev or prod)."
  type        = string
}
variable "subscription_id" {
  description = "Azure Subscription ID."
  type        = string
  #sensitive   = true
}

/*


variable "client_id" {
  description = "Azure Client ID (Service Principal App ID)."
  type        = string
  #sensitive   = true
}

variable "client_secret" {
  description = "Azure Client Secret (Service Principal Password)."
  type        = string
  #sensitive   = true
}

variable "tenant_id" {
  description = "Azure Tenant ID."
  type        = string
  #sensitive   = true
}
*/