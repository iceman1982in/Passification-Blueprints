data "azurerm_storage_account" "adfstr" {
  count               = var.startupsettingsadf ? 1 : 0
  name                = var.startupsettingsadf.storage_name
  resource_group_name = local.resource_groups[var.startupsettingsadf.resource_group_key].name  
}

resource "azurerm_storage_container" "adfctr" {
  name                  = var.startupsettingsadf.storage_container
  storage_account_name  = data.azurerm_storage_account.adfstr[count.index].name
  container_access_type = var.startupsettingsadf.container_access_type
  count                 = var.startupsettingsadf ? 1 : 0
}

data "azurerm_storage_account_blob_container_sas" "sasctr" {
  count             = var.startupsettingsadf ? 1 : 0
  connection_string = data.azurerm_storage_account.adfstr[count.index].primary_connection_string
  container_name    = try(azurerm_storage_container.adfctr[count.index].name , "default_adf_startup_container")
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
  count                  = var.startupsettingsadf ? 1 : 0
  for_each = fileset("${path.module}/file_uploads", "*")  
  name                   = each.key
  storage_account_name   = data.azurerm_storage_account.adfstr[count.index].name
  storage_container_name = try(azurerm_storage_container.adfctr[count.index].name , "default_adf_startup_container")
  type                   = "Block"
  source                 = "${path.module}/file_uploads/${each.key}"
}


