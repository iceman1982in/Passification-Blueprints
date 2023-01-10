
module "mssql_server_mi" {
  source = "../modules/data/mssqlservermi"

  for_each = {
    for key, value in try(var.sql_server_mi, {}) : key => value    
  }

  depends_on = [
    module.resource_groups
    
  ]

  sqlserver_name      = lookup(each.value, "name", null)
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = each.value.location
  #sqlversion          = each.value.sqlversion
  admin_username      = each.value.admin_username
  admin_password      = each.value.admin_password
  vnet_name           = each.value.vnet_name
  vnet_rg             = each.value.vnet_rg
  sku_name            = each.value.sku_name
  vcores              = each.value.vCores
  storage_size_in_gb = each.value.storage_size_in_gb
  license_type        = each.value.license_type
  subnet_name         = each.value.subnet_name
  azuread_administrator = each.value.azuread_administrator
  #tags           = each.value.tags
}







