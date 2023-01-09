data "azurerm_subnet" "primary" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name 
  resource_group_name  = var.vnet_rg
}

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

resource "azurerm_mssql_managed_instance" "primary" {
  name                = var.sqlserver_name
  resource_group_name = var.resource_group_name
  location            = var.location

  license_type       =  var.license_type
  sku_name           =  var.sku_name
  storage_size_in_gb =  var.storage_size_in_gb
  subnet_id          = data.azurerm_subnet.primary.id
  vcores             =  var.vcores

  administrator_login          = var.admin_username == null ? "sqladmin" : var.admin_username
  administrator_login_password = var.admin_password == null ? random_password.main.result : var.admin_password

  identity {
    type = "SystemAssigned"
  }

  #depends_on = [
  #  azurerm_subnet_network_security_group_association.example,
  #  azurerm_subnet_route_table_association.example,
  #]
   lifecycle {
    ignore_changes = [
      resource_group_name, location,tags
    ]
  }
}

/*resource "azurerm_mssql_managed_instance_active_directory_administrator" "primary" {
  managed_instance_id = azurerm_mssql_managed_instance.primary.id
  login_username      = var.azuread_administrator.login_username
  object_id           = var.azuread_administrator.object_id
  tenant_id           = var.azuread_administrator.tenant_id
}*/









