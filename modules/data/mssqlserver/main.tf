
resource "random_password" "main" {
  length      = var.random_password_length
  min_upper   = 4
  min_lower   = 2
  min_numeric = 4
  special     = false

  keepers = {
    administrator_login_password = var.sqlserver_name
  }
}



resource "azurerm_mssql_server" "primary" {
  name                         = var.sqlserver_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.sqlversion
  minimum_tls_version          = var.minimum_tls_version
  administrator_login          = var.admin_username == null ? "sqladmin" : var.admin_username
  administrator_login_password = var.admin_password == null ? random_password.main.result : var.admin_password
  tags                         =  var.tags

  identity {
    type = "SystemAssigned"
  }

  azuread_administrator {
    login_username      = var.azuread_administrator.login_username
    tenant_id           = var.azuread_administrator.tenant_id
    object_id           = var.azuread_administrator.object_id
  }
#   dynamic "identity" {
#     for_each = var.identity == true ? [1] : [0]
#     content {
#       type = "SystemAssigned"
#     }
#   }
}

#resource "azurerm_sql_active_directory_administrator" "primary" {
#  server_name         = azurerm_mssql_server.primary.name
#  resource_group_name = var.resource_group_name
#  login               = var.azuread_administrator.login_username
#  tenant_id           = var.azuread_administrator.tenant_id
#  object_id           = var.azuread_administrator.object_id
#}