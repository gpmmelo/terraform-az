<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>4.1.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.7.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~>4.1.0 |

## Modules◊◊◊◊

| Name | Source | Version |
|------|--------|---------|
| <a name="module_storage"></a> [storage](#module\_storage) | ../../modules/storage | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources | `map(string)` | <pre>{<br/>  "Cost-Center": "department it",<br/>  "Environment": "dev",<br/>  "Owner": "DevOps Team",<br/>  "Project": "developer"<br/>}</pre> | no |

## Outputs

No outputs.

````hcl
#sub
subscription_id = "xxxxxxxxxxxxxxxx"

#rg
name     = "rg-dev"
location = "eastus"

tags = {
  Project     = "developer"
  Owner       = "DevOps Team"
  Cost-Center = "department it"
  Environment = "dev"
}

#storage
    storage_account_name = "devstatefile123456"    # Storage account name
    container_name       = "dev-tfstate"           # Container name
    key                  = "dev.terraform.tfstate" # State file name for dev environment

````

<!-- END_TF_DOCS -->