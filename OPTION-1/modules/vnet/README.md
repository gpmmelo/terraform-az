<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_private_endpoint.private_endpoint](https://registry.terraform.io/providers/haVshicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_subnet.subnets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | The address space for the VNET. | `list(string)` | n/a | yes |
| <a name="input_ddos_protection_plan_id"></a> [ddos\_protection\_plan\_id](#input\_ddos\_protection\_plan\_id) | The ID of the DDoS protection plan to associate with the VNET. | `string` | `null` | no |
| <a name="input_enable_ddos_protection"></a> [enable\_ddos\_protection](#input\_enable\_ddos\_protection) | Enable DDoS protection for the VNET. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the VNET will be deployed. | `string` | n/a | yes |
| <a name="input_nsgs"></a> [nsgs](#input\_nsgs) | A map of Network Security Groups (NSGs) to create. | <pre>map(object({<br/>    rules = list(object({<br/>      name                       = string<br/>      priority                   = number<br/>      direction                  = string<br/>      access                     = string<br/>      protocol                   = string<br/>      source_port_range          = string<br/>      destination_port_range     = string<br/>      source_address_prefix      = string<br/>      destination_address_prefix = string<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | A map of private endpoints to create. | <pre>map(object({<br/>    subnet_key                      = string<br/>    private_service_connection_name = string<br/>    private_connection_resource_id  = string<br/>    is_manual_connection            = bool<br/>    subresource_names               = list(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where the VNET will be deployed. | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A map of subnets to create within the VNET. | <pre>map(object({<br/>    address_prefixes = list(string)<br/>    nsg_id          = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the VNET. | `map(string)` | `{}` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Name of the Virtual Network (VNET). | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nsg_ids"></a> [nsg\_ids](#output\_nsg\_ids) | A map of NSG names to their IDs. |
| <a name="output_private_endpoint_ids"></a> [private\_endpoint\_ids](#output\_private\_endpoint\_ids) | A map of private endpoint names to their IDs. |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | A map of subnet names to their IDs. |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | The ID of the Virtual Network (VNET). |
<!-- END_TF_DOCS -->