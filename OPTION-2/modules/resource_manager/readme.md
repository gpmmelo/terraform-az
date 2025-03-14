---
subcategory: "Base"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_resource_group"
description: |-
  Manages a Resource Group.
---

# azurerm_resource_group

Manages a Resource Group.

-> **Note:** Azure automatically deletes any Resources nested within the Resource Group when a Resource Group is deleted.

-> Version 2.72 and later of the Azure Provider include a Feature Toggle which can error if there are any Resources left within the Resource Group at deletion time. This Feature Toggle is disabled in 2.x but enabled by default from 3.0 onwards, and is intended to avoid the unintentional destruction of resources managed outside of Terraform (for example, provisioned by an ARM Template). See [the Features block documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#features) for more information on Feature Toggles within Terraform.

## Example Usage

```hcl
resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "West Europe"
}
```

## Arguments Reference

The following arguments are supported:

* `location` - (Required) The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created.

* `name` - (Required) The Name which should be used for this Resource Group. Changing this forces a new Resource Group to be created.

---

* `tags` - (Optional) A mapping of tags which should be assigned to the Resource Group.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported: 

* `id` - The ID of the Resource Group.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 1 hour and 30 minutes) Used when creating the Resource Group.
* `read` - (Defaults to 5 minutes) Used when retrieving the Resource Group.
* `update` - (Defaults to 1 hour and 30 minutes) Used when updating the Resource Group.
* `delete` - (Defaults to 1 hour and 30 minutes) Used when deleting the Resource Group.

## Import

Resource Groups can be imported using the `resource id`, e.g.

```shell
terraform import azurerm_resource_group.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example
```

# Resource: 

### Recovery
- azurerm_recovery_services_vault
- azurerm_site_recovery_fabric
- azurerm_site_recovery_replication_policy

### Resource_group
- azurerm_resource_group

| Name                                                                                                                                                               | Type     |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)                                           | resource |
| [azurerm_recovery_services_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/recovery_services_vault)                         | resource |
| [azurerm_site_recovery_fabric](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_fabric)                               | resource |
| [azurerm_site_recovery_replication_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_replication_policy)       | resource |


## Inputs

| Name                                                                                 | Description                                                                                                                  | Type                                                                    | Default                                                                      | Required |
|--------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------- |-------------------------------------------------------------------------|------------------------------------------------------------------------------|:--------:|
| <a name="input_name"></a> [vnet\_name](#input\_name)                                 | The Name which should be used for this Resource Group.                                                                       | `string`                                                                | n/a                                                                          |   yes    | 
| <a name="input_location"></a> [vnet\_location](#input\_location)                     | The Azure Region where the Resource Group should exist.                                                                      | `string`                                                                | n/a                                                                          |   yes    | 
| <a name="input_tags"></a> [tags](#input\_tags)                                       | The tags to associate with your network and subnets.                                                                         | `map(string)`                                                           | n/a                                                                          |   yes    | 
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id)    | The ID of the Subscription to be associated with the Management Group. Changing this forces a new Management to be created.  | `string`                                                                | n/a                                                                          |   yes    | 
| <a name="input_site_recovery"></a> [subscription](#input\_site_recovery)             | The site_recovery to enable/disable.                                                                                         | `bool`                                                                  | n/a                                                                          |   yes    | 
