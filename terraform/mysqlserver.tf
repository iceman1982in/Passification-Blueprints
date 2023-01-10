
module "mysql_server" {
  source = "../modules/data/mysqlserver"

  for_each = {
    for key, value in try(var.mysql_server, {}) : key => value    
  }

  depends_on = [
    module.resource_groups
    
  ]

  mysqlserver_name      = lookup(each.value, "name", null)
  mysqlversion          = each.value.sqlversion
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = each.value.location
  
  admin_username      = each.value.admin_username
  admin_password      = each.value.admin_password
  sku_name            = each.value.sku_name 

  azuread_administrator = each.value.azuread_administrator  
  
  
  backup_retention_days             = each.value.backup_retention_days
  geo_redundant_backup_enabled      = each.value.geo_redundant_backup_enabled
  # infrastructure_encryption_enabled = each.value.infrastructure_encryption_enabled
  # public_network_access_enabled     = each.value.public_network_access_enabled
  # ssl_enforcement_enabled           = each.value.ssl_enforcement_enabled
  # ssl_minimal_tls_version_enforced  = each.value.ssl_minimal_tls_version_enforced
  #auto_grow_enabled                 = each.value.auto_grow_enabled
  #tags                         =  var.tags
    #storage_size_in_mb = each.value.storage_size_in_mb
}




