
module "mysql_server_db" {
   source = "../modules/data/mysqldatabase"

  for_each = {
    for key, value in try(var.mysql_server_db, {}) : key => value
    //if try(value.enabled, false) == true
  }
  depends_on = [
    module.resource_groups,
    module.mysql_server
  ]

  database_name                = each.value.name
  resource_group_name          = local.resource_groups[each.value.resource_group_key].name  
  sql_servername                  = local.mysqlservers[each.value.server_key].name  
  charset = each.value.charset
  collation = each.value.collation
  
  
  #tags                        = each.value.tags
}
