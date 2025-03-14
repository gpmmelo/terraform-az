# Create the Azure VNET
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  # Optional: Enable DDoS Protection Plan
  dynamic "ddos_protection_plan" {
    for_each = var.enable_ddos_protection ? [1] : []
    content {
      id     = var.ddos_protection_plan_id
      enable = true
    }
  }
}

# Create Subnets
resource "azurerm_subnet" "subnets" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.address_prefixes

  # Optional: Associate NSG with Subnet
  dynamic "delegation" {
    for_each = each.value.nsg_id != null ? [1] : []
    content {
      name = "nsg-association"
      service_delegation {
        name    = "Microsoft.Network/networkSecurityGroups"
        actions = ["Microsoft.Network/networkSecurityGroups/join/action"]
      }
    }
  }
}

# Create Network Security Groups (NSGs)
resource "azurerm_network_security_group" "nsg" {
  for_each            = var.nsgs
  name                = each.key
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = each.value.rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

# Optional: Private Endpoints
resource "azurerm_private_endpoint" "private_endpoint" {
  for_each            = var.private_endpoints
  name                = each.key
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.subnets[each.value.subnet_key].id

  private_service_connection {
    name                           = each.value.private_service_connection_name
    private_connection_resource_id = each.value.private_connection_resource_id
    is_manual_connection           = each.value.is_manual_connection
    subresource_names              = each.value.subresource_names
  }
}