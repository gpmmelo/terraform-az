variable "name" {
  type = string
}
variable "location" {
  type = string
  default = "eastus"
}
variable "tags" {
  type = map(string)
}
variable "subscription_id" {
  type = string
}
variable "site_recovery" {
  type    = bool
  default = "false"
}
variable "key_vault" {
  type    = bool
  default = "false"
}