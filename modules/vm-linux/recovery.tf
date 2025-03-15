data "azurerm_virtual_network" "current" {
  name                = var.vnet
  resource_group_name = var.resource_group_name
}
data "azurerm_resource_group" "recovery" {
  name = "${var.resource_group_name}-asr"
}

data "azurerm_recovery_services_vault" "main" {
  name                = "principal-recovery-vault"
  resource_group_name = "${var.resource_group_name}-asr"
}

data "azurerm_site_recovery_fabric" "main" {
  name                = "principal-recovery-fabric"
  recovery_vault_name = "principal-recovery-vault"
  resource_group_name = "${var.resource_group_name}-asr"
}

data "azurerm_site_recovery_replication_policy" "main" {
  name                = "principal-recovery-policy"
  recovery_vault_name = "principal-recovery-vault"
  resource_group_name = "${var.resource_group_name}-asr"
}

data "azurerm_managed_disk" "os_disk" {
  name                = azurerm_linux_virtual_machine.vm.os_disk[0].name
  resource_group_name = var.resource_group_name
}

#SOURCE
resource "azurerm_site_recovery_protection_container" "source" {
  count = var.site_recovery ? 1 : 0

  name                 = "${var.name}-container-source"
  resource_group_name  = "${var.resource_group_name}-asr"
  recovery_vault_name  = data.azurerm_recovery_services_vault.main.name
  recovery_fabric_name = data.azurerm_site_recovery_fabric.main.name
}

resource "azurerm_storage_account" "source" {
  count = var.site_recovery ? 1 : 0

  name                     = "${var.name}cache"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action             = "Deny"
    bypass                     = ["AzureServices"]
    virtual_network_subnet_ids = [data.azurerm_subnet.current.id]
  }
  queue_properties  {

    logging {
      delete                = true
      read                  = true
      write                 = true
      version               = "1.0"
      retention_policy_days = 10
    }

    hour_metrics {
      enabled               = true
      include_apis          = true
      version               = "1.0"
      retention_policy_days = 10
    }

    minute_metrics {
      enabled               = true
      include_apis          = true
      version               = "1.0"
      retention_policy_days = 10
    }
  }
}

resource "azurerm_site_recovery_protection_container_mapping" "current" {
  count = var.site_recovery ? 1 : 0

  name                                      = "${var.name}-container-mapping"
  resource_group_name                       = "${var.resource_group_name}-asr"
  recovery_vault_name                       = data.azurerm_recovery_services_vault.main.name
  recovery_fabric_name                      = data.azurerm_site_recovery_fabric.main.name
  recovery_source_protection_container_name = azurerm_site_recovery_protection_container.source[count.index].name
  recovery_target_protection_container_id   = azurerm_site_recovery_protection_container.target[count.index].id
  recovery_replication_policy_id            = data.azurerm_site_recovery_replication_policy.main.id

  depends_on = [
    azurerm_site_recovery_protection_container.source,
    azurerm_site_recovery_protection_container.target
  ]
}

#TARGET
resource "azurerm_site_recovery_protection_container" "target" {
  count = var.site_recovery ? 1 : 0

  name                 = "${var.name}-container-target"
  resource_group_name  = "${var.resource_group_name}-asr"
  recovery_vault_name  = data.azurerm_recovery_services_vault.main.name
  recovery_fabric_name = data.azurerm_site_recovery_fabric.main.name
}

resource "azurerm_site_recovery_replicated_vm" "current" {
  count = var.site_recovery ? 1 : 0

  name = "${var.name}-replica"

  resource_group_name            = "${var.resource_group_name}-asr"
  recovery_vault_name            = data.azurerm_recovery_services_vault.main.name
  recovery_replication_policy_id = data.azurerm_site_recovery_replication_policy.main.id

  source_vm_id                              = azurerm_linux_virtual_machine.vm.id
  source_recovery_fabric_name               = data.azurerm_site_recovery_fabric.main.name
  source_recovery_protection_container_name = azurerm_site_recovery_protection_container.source[count.index].name

  target_resource_group_id                = data.azurerm_resource_group.recovery.id
  target_recovery_fabric_id               = data.azurerm_site_recovery_fabric.main.id
  target_recovery_protection_container_id = azurerm_site_recovery_protection_container.target[count.index].id

  target_network_id = data.azurerm_virtual_network.current.id
  target_zone       = "2"

  managed_disk {
    disk_id                    = data.azurerm_managed_disk.os_disk.id
    staging_storage_account_id = azurerm_storage_account.source[count.index].id
    target_resource_group_id   = data.azurerm_resource_group.recovery.id
    target_disk_type           = var.bootdisk_type
    target_replica_disk_type   = var.bootdisk_type
  }

  dynamic "managed_disk" {
    for_each = azurerm_managed_disk.disk

    content {
      disk_id                    = managed_disk.value.id
      staging_storage_account_id = azurerm_storage_account.source[count.index].id
      target_resource_group_id   = data.azurerm_resource_group.recovery.id
      target_disk_type           = managed_disk.value.storage_account_type
      target_replica_disk_type   = managed_disk.value.storage_account_type
    }
  }


  network_interface {
    source_network_interface_id = azurerm_network_interface.nic.id
    target_subnet_name          = var.subnet
  }

  depends_on = [
    azurerm_site_recovery_protection_container_mapping.current,
    azurerm_virtual_machine_extension.disk_formatter
  ]
}