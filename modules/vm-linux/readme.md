# Linux Virtual Machine Module
This module creates a VM prepared to receive Linux images and listening in RDP and WinRM ports.

## Data: 

### Compute
azurerm_subnet
azurerm_key_vault

### Recovery
azurerm_virtual_network
azurerm_resource_group
azurerm_recovery_services_vault
azurerm_site_recovery_fabric
azurerm_site_recovery_replication_policy
azurerm_managed_disk

| Name                                                                                                                                                                | Type        |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [azurerm_virtual_network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network)                                       | Data Source |
| [azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group)                                         | Data Source |
| [azurerm_recovery_services_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/recovery_services_vault)                       | Data Source |
| [azurerm_site_recovery_fabric](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/site_recovery_fabric)                             | Data Source |
| [azurerm_site_recovery_replication_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/site_recovery_replication_policy)     | Data Source |
| [azurerm_managed_disk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/managed_disk)                                             | Data Source |

## Resource: 

### Compute
azurerm_network_interface
azurerm_linux_virtual_machine
azurerm_managed_disk
azurerm_virtual_machine_extension
azurerm_virtual_machine_data_disk_attachment
random_password
azurerm_key_vault_secret
azurerm_key_vault_key
azurerm_disk_encryption_set

### Recovery
azurerm_site_recovery_protection_container
azurerm_storage_account
azurerm_site_recovery_protection_container_mapping
azurerm_site_recovery_replicated_vm

| Name                                                                                                                                                                                | Type     |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [azurerm_network_interface](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface)                                                      | resource |
| [azurerm_linux_virtual_machine](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine)                                          | resource |
| [azurerm_managed_disk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk)                                                                | resource |
| [azurerm_virtual_machine_extension](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension)                                      | resource |
| [azurerm_virtual_machine_data_disk_attachment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment)                | resource |
| [azurerm_random_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password)                                                                  | resource |
| [azurerm_key_vault_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret)                                                        | resource |
| [azurerm_key_vault_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key)                                                              | resource |
| [azurerm_disk_encryption_set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set)                                                  | resource |
| [azurerm_site_recovery_protection_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_protection_container)                    | resource |
| [azurerm_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)                                                          | resource |
| [azurerm_site_recovery_protection_container_mapping](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_protection_container_mapping)    | resource |
| [azurerm_site_recovery_replicated_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_replicated_vm)                                  | resource |

## Argument Reference: azurerm_network_interface

The following arguments are supported:

* `ip_configuration` - (Required) One or more `ip_configuration` blocks as defined below.
* `location` - (Required) The location where the Network Interface should exist. Changing this forces a new resource to be created.
* `name` - (Required) The name of the Network Interface. Changing this forces a new resource to be created.
* `resource_group_name` - (Required) The name of the Resource Group in which to create the Network Interface. Changing this forces a new resource to be created.

The `ip_configuration` block supports the following:
* `name` - (Required) A name used for this IP Configuration.
* `gateway_load_balancer_frontend_ip_configuration_id` - (Optional) The Frontend IP Configuration ID of a Gateway SKU Load Balancer.
* `subnet_id` - (Optional) The ID of the Subnet where this Network Interface should be located in.

~>  **Note:** This is required when `private_ip_address_version` is set to `IPv4`.

* `private_ip_address_version` - (Optional) The IP Version to use. Possible values are `IPv4` or `IPv6`. Defaults to `IPv4`.
* `private_ip_address_allocation` - (Required) The allocation method used for the Private IP Address. Possible values are `Dynamic` and `Static`.

When `private_ip_address_allocation` is set to `Static` the following fields can be configured:
* `private_ip_address` - (Optional) The Static IP Address which should be used.

When `private_ip_address_version` is set to `IPv4` the following fields can be configured:
* `subnet_id` - (Required) The ID of the Subnet where this Network Interface should be located in.

~> **Note:** `Dynamic` means "An IP is automatically assigned during creation of this Network Interface"; `Static` means "User supplied IP address will be used"

## Argument Reference: random_password 

Identical to [random_string](string.html) with the exception that the result is treated as sensitive and, thus, _not_ displayed in console output. Read more about sensitive data handling in the [Terraform documentation](https://www.terraform.io/docs/language/state/sensitive-data.html).


## Argument Reference: azurerm_key_vault_secret

The following arguments are supported:

* `name` - (Required) Specifies the name of the Key Vault Secret. Changing this forces a new resource to be created.
* `value` - (Required) Specifies the value of the Key Vault Secret.
~> **Note:** Key Vault strips newlines. To preserve newlines in multi-line secrets try replacing them with `\n` or by base 64 encoding them with `replace(file("my_secret_file"), "/\n/", "\n")` or `base64encode(file("my_secret_file"))`, respectively.
* `key_vault_id` - (Required) The ID of the Key Vault where the Secret should be created.

# Argument Reference: azurerm_linux_virtual_machine

The following arguments are supported:

* `name` - (Required) The name of the Linux Virtual Machine. Changing this forces a new resource to be created.
* `location` - (Required) The Azure location where the Linux Virtual Machine should exist. Changing this forces a new resource to be created.
* `resource_group_name` - (Required) The name of the Resource Group in which the Linux Virtual Machine should be exist. Changing this forces a new resource to be created.
* `size` - (Required) The SKU which should be used for this Virtual Machine, such as `Standard_F2`.
* `admin_password` - (Required) The Password which should be used for the local-administrator on this Virtual Machine. Changing this forces a new resource to be created.
* `admin_username` - (Required) The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created.
* `zone` - * `zones` - (Optional) Specifies the Availability Zone in which this Linux Virtual Machine should be located. Changing this forces a new Linux Virtual Machine to be created.
* `network_interface_ids` - (Required). A list of Network Interface IDs which should be attached to this Virtual Machine. The first Network Interface ID in this list will be the Primary Network Interface on the Virtual Machine.
* `patch_mode` - (Optional) Specifies the mode of in-guest patching to this Linux Virtual Machine. Possible values are `Manual`, `AutomaticByOS` and `AutomaticByPlatform`. Defaults to `AutomaticByOS`. For more information on patch modes please see the [product documentation](https://docs.microsoft.com/azure/virtual-machines/automatic-vm-guest-patching#patch-orchestration-modes).
* `enable_automatic_updates` - (Optional) Specifies if Automatic Updates are Enabled for the Linux Virtual Machine. Changing this forces a new resource to be created. Defaults to `false`.

---
* `os_disk` - (Required) A `os_disk` block as defined below.

A `os_disk` block supports the following:
* `caching` - (Required) The Type of Caching which should be used for the Internal OS Disk. Possible values are `None`, `ReadOnly` and `ReadWrite`.
* `storage_account_type` - (Required) The Type of Storage Account which should back this the Internal OS Disk. Possible values are `Standard_LRS`, `StandardSSD_LRS`, `Premium_LRS`, `StandardSSD_ZRS` and `Premium_ZRS`. Changing this forces a new resource to be created.
* `disk_size_gb` - (Optional) The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from.
---

---
-> **NOTE:** If specified this must be equal to or larger than the size of the Image the Virtual Machine is based on. When creating a larger disk than exists in the image you'll need to repartition the disk to use the remaining space.
---

---
-> **NOTE:** One of either `source_image_id` or `source_image_reference` must be set.
---

---
* `source_image_reference` - (Optional) A `source_image_reference` block as defined below. Changing this forces a new resource to be created.

`source_image_reference` supports the following:
* `publisher` - (Optional) Specifies the publisher of the image used to create the virtual machines.
* `offer` - (Optional) Specifies the offer of the image used to create the virtual machines.
* `sku` - (Optional) Specifies the SKU of the image used to create the virtual machines.
* `version` - (Optional) Specifies the version of the image used to create the virtual machines.
---

---
* `source_image_id` - (Optional) The ID of the Image which this Virtual Machine should be created from. Changing this forces a new resource to be created. Possible Image ID types include `Image ID`s, `Shared Image ID`s, `Shared Image Version ID`s, `Community Gallery Image ID`s, `Community Gallery Image Version ID`s, `Shared Gallery Image ID`s and `Shared Gallery Image Version ID`s.
---

* `plan` - (Required) A `plan` block as defined below:

A `plan` block supports the following:
* `name` - (Required) Specifies the Name of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
* `product` - (Required) Specifies the Product of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
* `publisher` - (Required) Specifies the Publisher of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
---

---
A `boot_diagnostics` block supports the following:
* `storage_account_uri` - (Optional) The Primary/Secondary Endpoint for the Azure Storage Account which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor.
---

---
-> **NOTE:** Passing a null value will utilize a Managed Storage Account to store Boot Diagnostics.
---

---
An `identity` block supports the following:

* `type` - (Required) Specifies the type of Managed Service Identity that should be configured on this Linux Virtual Machine. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both).
* `identity_ids` - (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Linux Virtual Machine.
---
---
~> **NOTE:** This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`.
---

* `tags` - (Optional) A mapping of tags which should be assigned to this Virtual Machine.

# Argument Reference: azurerm_managed_disk

The following arguments are supported:

* `name` - (Required) Specifies the name of the Managed Disk. Changing this forces a new resource to be created.
* `resource_group_name` - (Required) The name of the Resource Group where the Managed Disk should exist.
* `location` - (Required) Specified the supported Azure location where the resource exists. Changing this forces a new resource to be created.
* `storage_account_type` - (Required) The type of storage to use for the managed disk. Possible values are `Standard_LRS`, `StandardSSD_ZRS`, `Premium_LRS`, `PremiumV2_LRS`, `Premium_ZRS`, `StandardSSD_LRS` or `UltraSSD_LRS`.
* `create_option` - (Required) The method to use when creating the managed disk. Changing this forces a new resource to be created. Possible values include:
 * `Import` - Import a VHD file in to the managed disk (VHD specified with `source_uri`).
 * `Empty` - Create an empty managed disk.
 * `Copy` - Copy an existing managed disk or snapshot (specified with `source_resource_id`).
 * `FromImage` - Copy a Platform Image (specified with `image_reference_id`)
 * `Restore` - Set by Azure Backup or Site Recovery on a restored disk (specified with `source_resource_id`).
* `encryption_settings` - (Optional) A `encryption_settings` block as defined below. Defaults to `false`.

## Argument Reference: azurerm_virtual_machine_data_disk_attachment

The following arguments are supported:

* `virtual_machine_id` - (Required) The ID of the Virtual Machine to which the Data Disk should be attached. Changing this forces a new resource to be created.
* `managed_disk_id` - (Required) The ID of an existing Managed Disk which should be attached. Changing this forces a new resource to be created.
* `lun` - (Required) The Logical Unit Number of the Data Disk, which needs to be unique within the Virtual Machine. Changing this forces a new resource to be created.
* `caching` - (Required) Specifies the caching requirements for this Data Disk. Possible values include `None`, `ReadOnly` and `ReadWrite`.

## Argument Reference: azurerm_virtual_machine_extension

The following arguments are supported:

* `name` - (Required) The name of the virtual machine extension peering. Changing
    this forces a new resource to be created.
* `virtual_machine_id` - (Required) The ID of the Virtual Machine. Changing this forces a new resource to be created
* `publisher` - (Required) The publisher of the extension, available publishers can be found by using the Azure CLI. Changing this forces a new resource to be created.
* `type` - (Required) The type of extension, available types for a publisher can
    be found using the Azure CLI.

~> **Note:** The `Publisher` and `Type` of Virtual Machine Extensions can be found using the Azure CLI, via:

```shell
az vm extension image list --location westus -o table
```

* `type_handler_version` - (Required) Specifies the version of the extension to
    use, available versions can be found using the Azure CLI.

* `auto_upgrade_minor_version` - (Optional) Specifies if the platform deploys
    the latest minor version update to the `type_handler_version` specified.

* `automatic_upgrade_enabled` - (Optional) Should the Extension be automatically updated whenever the Publisher releases a new version of this VM Extension? Defaults to `false`.
* `settings` - (Optional) The settings passed to the extension, these are
    specified as a JSON object in a string.

~> **Please Note:** Certain VM Extensions require that the keys in the `settings` block are case sensitive. If you're seeing unhelpful errors, please ensure the keys are consistent with how Azure is expecting them (for instance, for the `JsonADDomainExtension` extension, the keys are expected to be in `TitleCase`.)

* `protected_settings` - (Optional) The protected_settings passed to the
    extension, like settings, these are specified as a JSON object in a string.

~> **Please Note:** Certain VM Extensions require that the keys in the `protected_settings` block are case sensitive. If you're seeing unhelpful errors, please ensure the keys are consistent with how Azure is expecting them (for instance, for the `JsonADDomainExtension` extension, the keys are expected to be in `TitleCase`.)

## Outputs

NO