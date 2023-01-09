resource "azurerm_data_factory" "data_factory" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  public_network_enabled = var.public_network_enabled
  managed_virtual_network_enabled = var.managed_virtual_network_enabled

   identity {
    type = "SystemAssigned"
  }

   lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
            tags
    ]
  }
}