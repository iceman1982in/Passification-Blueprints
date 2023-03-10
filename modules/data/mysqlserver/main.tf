resource "random_password" "main" {
  length      = var.random_password_length
  min_upper   = 4
  min_lower   = 2
  min_numeric = 4
  special     = false

  keepers = {
    administrator_login_password = var.mysqlserver_name
  }
}


resource "azurerm_mysql_flexible_server" "primary" {
  name                         = var.mysqlserver_name
  location                     = var.location
  resource_group_name          = var.resource_group_name

  administrator_login          = var.admin_username == null ? "sqladmin" : var.admin_username
  administrator_password  = var.admin_password == null ? random_password.main.result : var.admin_password

  sku_name   =  var.sku_name
  # storage_mb =  var.storage_size_in_mb  
  version = var.mysqlversion 


  #auto_grow_enabled                 = try(var.auto_grow_enabled,true)
  backup_retention_days             = var.backup_retention_days  
  geo_redundant_backup_enabled      = try(var.geo_redundant_backup_enabled,false)
  zone                              = "2" // TO-DO: MOVE THIS TO VARIABLE
  
  # infrastructure_encryption_enabled = try(var.infrastructure_encryption_enabled,false)
  # public_network_access_enabled     = try(var.public_network_access_enabled,true)
  # ssl_enforcement_enabled           = try(var.ssl_enforcement_enabled,true)
  # ssl_minimal_tls_version_enforced  = var.ssl_minimal_tls_version_enforced
  tags                         =  var.tags

  # identity {
  #   type = "SystemAssigned"
  # }

}
