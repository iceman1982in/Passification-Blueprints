
module "mssql_server" {
   source = "../modules/data/mssqlserver"

  for_each = {
    for key, value in try(var.sql_server, {}) : key => value
    //if try(value.enabled, false) == true
  }

  depends_on = [
    module.resource_groups,
    module.keyvault
  ]

  sqlserver_name      = lookup(each.value, "name", null)
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = each.value.location
  sqlversion          = each.value.sqlversion
  admin_username      = each.value.admin_username
  admin_password      = each.value.admin_password
  azuread_administrator = each.value.azuread_administrator
  #public_network_access_enabled = each.value.public_network_access_enabled
  #tags           = each.value.tags
}


module "mssql_server_db" {
   source = "../modules/data/mssqldatabase"

  for_each = {
    for key, value in try(var.sql_server_db, {}) : key => value
    //if try(value.enabled, false) == true
  }
  depends_on = [
    module.resource_groups,
    module.mssql_server
  ]

  database_name                = each.value.name
  resource_group_name          = local.resource_groups[each.value.resource_group_key].name
  location                     = each.value.location
  sql_servername               = each.value.server_name
  sql_database_edition         = each.value.edition
  sqldb_service_objective_name = each.value.service_objective_name
  
  #tags                        = each.value.tags
}




