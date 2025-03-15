variable "resource_group_name" {
  description = "The name of the resource group where the Virtual Network will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be deployed."
  type        = string
}

variable "vnet_name" {
  description = "The name of the Virtual Network."
  type        = string
}

variable "address_space" {
  description = "The address space for the Virtual Network."
  type        = list(string)
  #default     = ["10.0.0.0/16"]
}

variable "subnet_prefixes" {
  description = "The address prefixes for subnets within the Virtual Network."
  type        = list(string)
  #default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "subnet_names" {
  description = "The names of the subnets within the Virtual Network."
  type        = list(string)
  # default     = ["subnet1", "subnet2"]
}

variable "tags" {
  description = "A map of tags to apply to the Virtual Network."
  type        = map(string)
  #default     = {}
}