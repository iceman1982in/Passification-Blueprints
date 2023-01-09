data "azurerm_storage_account" "adfstr" {
  name                = var.startupsettingsadf.storage_name
  resource_group_name = local.resource_groups[var.startupsettingsadf.resource_group_key].name  
}

resource "azurerm_storage_container" "adfctr" {
  name                  = var.startupsettingsadf.storage_container
  storage_account_name  = data.azurerm_storage_account.adfstr.name
  container_access_type = var.startupsettingsadf.container_access_type
}

data "azurerm_storage_account_blob_container_sas" "sasctr" {
  connection_string = data.azurerm_storage_account.adfstr.primary_connection_string
  container_name    = azurerm_storage_container.adfctr.name
  https_only        = true

  start  = var.startupsettingsadf.start
  expiry = var.startupsettingsadf.expiry

  permissions {
    read   = true
    add    = true
    create = true
    write  = true
    delete = false
    list   = true
  }
}


resource "azurerm_storage_blob" "tamopsblobs" {
  for_each = fileset("${path.module}/file_uploads", "*")  
  name                   = each.key
  storage_account_name   = data.azurerm_storage_account.adfstr.name
  storage_container_name = azurerm_storage_container.adfctr.name
  type                   = "Block"
  source                 = "${path.module}/file_uploads/${each.key}"
}


