resource "azurerm_sql_database" "db" {
  name                             = var.database_name
  resource_group_name              = var.resource_group_name
  location                         = var.location
  server_name                      = var.sql_servername
  edition                          = var.sql_database_edition
  requested_service_objective_name = var.sqldb_service_objective_name
  tags                             =  var.tags


  

#   dynamic "threat_detection_policy" {
#     for_each = local.if_threat_detection_policy_enabled
#     content {
#       state                      = "Enabled"
#       storage_endpoint           = azurerm_storage_account.storeacc.0.primary_blob_endpoint
#       storage_account_access_key = azurerm_storage_account.storeacc.0.primary_access_key
#       retention_days             = var.log_retention_days
#       email_addresses            = var.email_addresses_for_alerts
#     }
#   }
}