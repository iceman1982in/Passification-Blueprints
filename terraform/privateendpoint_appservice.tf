
module "privatednszone_appserv" {
    source = "../modules/privatednszone_reused"

    for_each = {
       for key, value in try(var.privateendpoint_appservice, {}) : key => value    
    }

     providers = {
       azurerm = azurerm.core-sub
   }

    private_dns_zone = try(each.value.private_dns_zone, null)
    private_dns_zone_resource_group = try(each.value.private_dns_zone_resource_group, null)    
}


module "privateendpoint_appservice" {
    source = "../modules/privateendpoint"

    for_each = {
       for key, value in try(var.privateendpoint_appservice, {}) : key => value    
    }

     depends_on = [
        module.appservice, module.privatednszone_appserv
     ]

    resource_group_name     = local.resource_groups[each.value.resource_group_key].name 
    network_resource_group  =  try(each.value.network_resource_group, null)
    virtual_network_name    = try(each.value.virtual_network_name, null)
    subnet_name             = try(each.value.subnet_name, null)
    name                    = try(each.value.name, null)
    private_link_enabled_resource_id = module.appservice[each.value.key].app_service_id
    dns_zone_group_name = try(each.value.dns_zone_group_name, null)
    priv-dns-id = module.privatednszone_appserv[each.key].id
 
    # you can add other subresouce also
    subresource_name = each.value.subresource_name   
  
}

