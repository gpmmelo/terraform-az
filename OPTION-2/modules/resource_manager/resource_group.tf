resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "recovery" {
  count = var.site_recovery ? 1 : 0

  name     = "${azurerm_resource_group.rg.name}-"
  location = azurerm_resource_group.rg.location
  tags     = azurerm_resource_group.rg.tags
}