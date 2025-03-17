<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.1.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_compute"></a> [compute](#module\_compute) | ../../modules/compute | n/a |
| <a name="module_network"></a> [network](#module\_network) | ../../modules/network | n/a |
| <a name="module_rg"></a> [rg](#module\_rg) | ../../modules/resource_group | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | Address space for the virtual network | `list(string)` | n/a | yes |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | Admin username for the virtual machine | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the resource group will be deployed. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_public_key_path"></a> [public\_key\_path](#input\_public\_key\_path) | Path to the public SSH key | `string` | n/a | yes |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | Name of the subnet | `string` | n/a | yes |
| <a name="input_subnet_prefixes"></a> [subnet\_prefixes](#input\_subnet\_prefixes) | Address prefixes for the subnet | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources | `map(string)` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Name of the virtual network | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | ID of the virtual network |


## Example the tfvars

````
#rg
name     = "rg-dev"
location = "eastus"

tags = {
  Project     = "developer"
  Owner       = "DevOps Team"
  Cost-Center = "department it"
  Environment = "dev"
}

#network
vnet_name       = "dev-vnet"
address_space   = ["10.0.0.0/16"]
subnet_name     = "dev-subnet"
subnet_prefixes = ["10.0.2.0/24"]

#compute
nic_name        = "dev-nic"
vm_name         = "dev-vm"
vm_size         = "Standard_F2"
admin_username  = "adminuser"
public_key_path = "~/.ssh/id_rsa.pub"
```
<!-- END_TF_DOCS -->