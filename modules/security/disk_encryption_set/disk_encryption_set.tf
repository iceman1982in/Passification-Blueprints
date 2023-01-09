resource "azurerm_disk_encryption_set" "encryption_set" {
  name                = var.settings.name
  resource_group_name = var.resource_group_name
  location            = lookup(var.settings, "region", null) == null ? var.global_settings.location : lookup(var.settings, "region", null)
  key_vault_key_id    = var.key_vault_key_ids[var.settings.key_vault_key_key].id

  identity {
    type = "SystemAssigned"
  }
  tags = merge(var.global_settings.tags, var.tags, try(var.settings.tags, null))
}