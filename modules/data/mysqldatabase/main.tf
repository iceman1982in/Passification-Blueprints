resource "azurerm_mysql_flexible_database" "db" {
  name                             = var.database_name
  resource_group_name              = var.resource_group_name  
  server_name                      = var.sql_servername
  charset = var.charset
  collation = var.collation 
}