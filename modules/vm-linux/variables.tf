variable "subnet" {
  type = string
}
variable "vnet" {
  type = string
}
variable "location" {
  type = string
  default = "germanywestcentral"
}
variable "resource_group_name" {
  type        = string
}
variable "ip_address" {
  type = string
}
variable "name" {
  type = string
}
variable "vm_size" {
  type = string
}
variable "zone" {
  type = string
}
variable "bootdisk_type" {
  type = string
}
variable "bootdisk_size" {
  type = number
}
variable "tags" {
  type = map(string)
}
variable "subscription_id" {
  type = string
}
variable "license_type" {
  type = string
  default = null
}

variable "site_recovery" {
  type    = bool
  default = false
}

variable "managed_disk" {
  default = {}

  type = map(object({
    name      = string
    disk_type = string
    disk_size = number
  }))
}

variable "image_id" {
  default = null
  type    = string
}

variable "image" {
  type = object({
    os_publisher = string
    os_offer     = string
    os_sku       = string
    os_version   = string
  })
  default = {
    os_offer     = null
    os_publisher = null
    os_sku       = null
    os_version   = null
  }
}

variable "plan" {
  type = object({
    os_publisher = string
    os_offer     = string
    os_sku       = string
  })
  default = {
    os_offer     = null
    os_publisher = null
    os_sku       = null
  }
}