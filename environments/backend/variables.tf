variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Project     = "developer"
    Owner       = "DevOps Team"
    Cost-Center = "department it"
    Environment = "dev"
  }
}