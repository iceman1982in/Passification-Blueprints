
module "privatednszone_storage" {
    source = "../modules/privatednszone_reused"

    for_each = {
       for key, value in try(var.privateendpoint_storage, {}) : key => value    
    }

     providers = {
       azurerm = azurerm.core-sub
   }

    private_dns_zone = try(each.value.private_dns_zone, null)
    private_dns_zone_resource_group = try(each.value.private_dns_zone_resource_group, null)    
}


module "privateendpoint_storage" {
    source = "../modules/privateendpoint"

     for_each = {
       for key, value in try(var.privateendpoint_storage, {}) : key => value    
      }

     depends_on = [
        module.storage_account,module.privatednszone_storage
     ]

    resource_group_name     = local.resource_groups[each.value.resource_group_key].name 
    network_resource_group  = each.value.network_resource_group
    virtual_network_name    = each.value.virtual_network_name
    subnet_name             = each.value.subnet_name
    name                    = each.value.name
    private_link_enabled_resource_id = module.storage_account[each.value.key].id
    dns_zone_group_name = try(each.value.dns_zone_group_name, null)
    priv-dns-id = module.privatednszone_storage[each.key].id
    # you can add other subresouce also
    subresource_name = each.value.subresource_name   
    
}

