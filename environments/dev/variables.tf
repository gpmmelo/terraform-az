variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

variable "admin_username" {
  description = "Admin username for the virtual machine"
  type        = string
}

variable "public_key_path" {
  description = "Path to the public SSH key"
  type        = string
}