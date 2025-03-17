variable "nic_name" {
  description = "Name of the network interface"
  type        = string
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet to attach the NIC"
  type        = string
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the virtual machine"
  type        = string
}

variable "public_key_path" {
  description = "Path to the public SSH key"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}