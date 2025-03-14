variable "vnet_name" {
  description = "Name of the Virtual Network (VNET)."
  type        = string
}

variable "address_space" {
  description = "The address space for the VNET."
  type        = list(string)
}

variable "location" {
  description = "The Azure region where the VNET will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the VNET will be deployed."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the VNET."
  type        = map(string)
  default     = {}
}

variable "subnets" {
  description = "A map of subnets to create within the VNET."
  type = map(object({
    address_prefixes = list(string)
    nsg_id          = optional(string)
  }))
  default = {}
}

variable "nsgs" {
  description = "A map of Network Security Groups (NSGs) to create."
  type = map(object({
    rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))
  default = {}
}

variable "enable_ddos_protection" {
  description = "Enable DDoS protection for the VNET."
  type        = bool
  default     = false
}

variable "ddos_protection_plan_id" {
  description = "The ID of the DDoS protection plan to associate with the VNET."
  type        = string
  default     = null
}

variable "private_endpoints" {
  description = "A map of private endpoints to create."
  type = map(object({
    subnet_key                      = string
    private_service_connection_name = string
    private_connection_resource_id  = string
    is_manual_connection            = bool
    subresource_names               = list(string)
  }))
  default = {}
}