#sub
variable "subscription_id" {}

#rg
variable "name" {
  description = "The name of the resource group."
  type        = string
}
variable "nic_name" {
  description = "Name of the network interface"
  type        = string
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
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
variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

############################################################################

#network

variable "public_ip_allocation" {
  description = "Public IP allocation method"
  type        = string
  default     = "Dynamic"
}

variable "nsg" {
  type = string
}
variable "name_public_ip" {
  type = string
  
}
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
