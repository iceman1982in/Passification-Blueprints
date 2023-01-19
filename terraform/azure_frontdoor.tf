module "front-door" {
    source = "../modules/apps/azure_frontdoor"

    for_each = {
    for key, value in try(var.azure_frontdoors, {}) : key => value
    //if try(value.enabled, false) == true
  }

  tags                                              = { Department = "Ops"}
  frontdoor_resource_group_name                     = local.resource_groups[each.value.resource_group_key].name
  frontdoor_name                                    = each.value.frontdoor_name
  frontdoor_loadbalancer_enabled                    =  each.value.frontdoor_loadbalancer_enabled
  backend_pools_send_receive_timeout_seconds        =  each.value.backend_pools_send_receive_timeout_seconds
    
  # frontend_endpoint      = [{
  #     name                                    = "my-frontdoor-frontend-endpoint"
  #     host_name                               = "my-frontdoor.azurefd.net"
  #     custom_https_provisioning_enabled       = false
  #     custom_https_configuration              = { certificate_source = "FrontDoor"}
  #     session_affinity_enabled                = false
  #     session_affinity_ttl_seconds            = 0
  #     waf_policy_link_id                      = ""
  # }]

  frontend_endpoint   = each.value.frontend_endpoints

  frontdoor_routing_rule = [{
      name               = "my-routing-rule"
      accepted_protocols = ["Http", "Https"] 
      patterns_to_match  = ["/*"]
      enabled            = true              
      configuration      = "Forwarding"
      forwarding_configuration = [{
        backend_pool_name                     = "backendBing"
        cache_enabled                         = true       
        cache_use_dynamic_compression         = false       
        cache_query_parameter_strip_directive = "StripNone" 
        custom_forwarding_path                = ""
        forwarding_protocol                   = "MatchRequest"   
      }]      
  }]

  frontdoor_loadbalancer =  [{      
      name                            = "loadbalancer"
      sample_size                     = 4
      successful_samples_required     = 2
      additional_latency_milliseconds = 0
  }]

  frontdoor_health_probe = [{      
      name                = "healthprobe"
      enabled             = true
      path                = "/"
      protocol            = "Http"
      probe_method        = "HEAD"
      interval_in_seconds = 60
  }]

  frontdoor_backend =  [{
      name               = "backendBing"
      load_balancing_name = "loadbalancer"
      health_probe_name  = "healthprobe"
      backend = [{
        enabled     = true
        host_header = "www.bing.com"
        address     = "www.bing.com"
        http_port   = 80
        https_port  = 443
        priority    = 1
        weight      = 50
      }]
  }]
    
}