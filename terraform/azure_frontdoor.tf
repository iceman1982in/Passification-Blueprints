module "front-door" {
    source = "../modules/apps/azure_frontdoor"

    for_each = {
      for key, value in try(var.azure_frontdoors, {}) : key => value    
    }

    tags                                              = { Department = "Ops"}
    frontdoor_resource_group_name                     = local.resource_groups[each.value.resource_group_key].name
    frontdoor_name                                    =  each.value.frontdoor_name
    frontdoor_loadbalancer_enabled                    =  each.value.frontdoor_loadbalancer_enabled
    backend_pools_send_receive_timeout_seconds        =  each.value.backend_pools_send_receive_timeout_seconds   
    frontend_endpoint   = each.value.frontend_endpoints
    frontdoor_routing_rule = each.value.frontdoor_routing_rule
    frontdoor_loadbalancer =  each.value.frontdoor_loadbalancer
    frontdoor_health_probe =  each.value.frontdoor_health_probe
    frontdoor_backend =  each.value.frontdoor_backend
    
}