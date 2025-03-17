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

#network
variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "subnet_prefixes" {
  description = "Address prefixes for the subnet"
  type        = list(string)
}

#compute
variable "admin_username" {
  description = "Admin username for the virtual machine"
  type        = string
}

variable "public_key_path" {
  description = "Path to the public SSH key"
  type        = string
}