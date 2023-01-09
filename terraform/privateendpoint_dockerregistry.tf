module "privatednszone_docker" {
    source = "../modules/privatednszone_reused"

    for_each = {
       for key, value in try(var.privateendpoint_dockerregistry, {}) : key => value    
    }

     providers = {
       azurerm = azurerm.core-sub
   }

    private_dns_zone = try(each.value.private_dns_zone, null)
    private_dns_zone_resource_group = try(each.value.private_dns_zone_resource_group, null)    
}


module "privateendpoint_dockerregistry" {
    source = "../modules/privateendpoint"

     for_each = {
       for key, value in try(var.privateendpoint_dockerregistry, {}) : key => value    
      }

     depends_on = [
        module.docker_registry,module.privatednszone_docker
     ]

    resource_group_name     = local.resource_groups[each.value.resource_group_key].name 
    network_resource_group  = each.value.network_resource_group
    virtual_network_name    = each.value.virtual_network_name
    subnet_name             = each.value.subnet_name
    name                    = each.value.name
    private_link_enabled_resource_id = module.docker_registry[each.value.key].id
    dns_zone_group_name = try(each.value.dns_zone_group_name, null)
    priv-dns-id = module.privatednszone_docker[each.key].id
    # you can add other subresouce also
    subresource_name = each.value.subresource_name   
    
}

