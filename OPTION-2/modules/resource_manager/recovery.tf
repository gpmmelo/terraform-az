resource "azurerm_recovery_services_vault" "main" {
  count = var.site_recovery ? 1 : 0

  name                = "principal-recovery-vault"
  location            = azurerm_resource_group.recovery[count.index].location
  resource_group_name = azurerm_resource_group.recovery[count.index].name
  sku                 = "Standard"

  soft_delete_enabled = false

  depends_on = [azurerm_resource_group.recovery]
}

resource "azurerm_site_recovery_fabric" "main" {
  count = var.site_recovery ? 1 : 0

  name                = "principal-recovery-fabric"
  location            = azurerm_resource_group.recovery[count.index].location
  resource_group_name = azurerm_resource_group.recovery[count.index].name
  recovery_vault_name = azurerm_recovery_services_vault.main[count.index].name

  depends_on = [azurerm_recovery_services_vault.main]
}

resource "azurerm_site_recovery_replication_policy" "main" {
  count = var.site_recovery ? 1 : 0

  name                                                 = "principal-recovery-policy"
  resource_group_name                                  = azurerm_resource_group.recovery[count.index].name
  recovery_vault_name                                  = azurerm_recovery_services_vault.main[count.index].name
  recovery_point_retention_in_minutes                  = 24 * 60
  application_consistent_snapshot_frequency_in_minutes = 4 * 60

  depends_on = [azurerm_recovery_services_vault.main]
}