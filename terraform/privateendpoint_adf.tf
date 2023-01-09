
module "privatednszone_adf" {
    source = "../modules/privatednszone_reused"

    for_each = {
       for key, value in try(var.privateendpoint_adf, {}) : key => value    
    }

     providers = {
       azurerm = azurerm.core-sub
   }

    private_dns_zone = try(each.value.private_dns_zone, null)
    private_dns_zone_resource_group = try(each.value.private_dns_zone_resource_group, null)    
}




module "privateendpoint_adf" {
    source = "../modules/privateendpoint"

    for_each = {
       for key, value in try(var.privateendpoint_adf, {}) : key => value    
    }

     depends_on = [
        module.data_factory, module.privatednszone_adf
     ]

    resource_group_name     = local.resource_groups[each.value.resource_group_key].name 
    network_resource_group  =  try(each.value.network_resource_group, null)
    virtual_network_name    = try(each.value.virtual_network_name, null)
    subnet_name             = try(each.value.subnet_name, null)
    name                    = try(each.value.name, null)
    private_link_enabled_resource_id = module.data_factory[each.value.key].id
    dns_zone_group_name = try(each.value.dns_zone_group_name, null)
    priv-dns-id = module.privatednszone_adf[each.key].id
 
    # you can add other subresouce also
    subresource_name = each.value.subresource_name   
  
}

