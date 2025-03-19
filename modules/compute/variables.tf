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
variable "vnet_address_space" {
  description = "Virtual network address space"
  type        = list(string)
}

variable "subnet_address_prefix" {
  description = "Subnet address prefix"
  type        = list(string)
}

variable "vm_size" {
  description = "VM size"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
}

variable "allowed_ssh_cidr" {
  description = "Allowed CIDR for SSH access"
  type        = string
  default     = "*"
}
variable "os_disk_type" {
  description = "OS disk type"
  type        = string
  default     = "Standard_LRS"
}

variable "public_ip_allocation" {
  description = "Public IP allocation method"
  type        = string
  default     = "Dynamic"
}

variable "nsg" {
  type = string
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

variable "name_public_ip" {
  type = string
}

variable "subnet_id" {

}