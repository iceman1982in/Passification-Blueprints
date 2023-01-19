subscription_id = "fb6eefcf-89bb-4ee1-8690-a799d5eb008e"
tenant_id       = "5c7fbefe-6f52-4cab-bb0f-099dc2e314b9" 
subscription_core_id = "fb6eefcf-89bb-4ee1-8690-a799d5eb008e" // TO-DO: Had to add but isn't being used in the pipeline
 
resource_groups = {
    shared = {
    name              = "ava-mod-poc-shared-rg"
    enabled           = true
    reuse             = true // false => will deploy the resource ; true => if the resource group exists
    location          = "eastus2" // TO-DO: - how to move this to a variable ?
    naming_convention = "name_mask:{name}" // TO-DO: - how to apply naming convention in all resources?
  }  
}


azure_frontdoors = {
  frontdoor1 = {
    tags                                   = { Department = "Ops"}
    resource_group_key                     =  "shared"
    frontdoor_name                                    = "my-frontdoor"
    frontdoor_loadbalancer_enabled                    = true
    backend_pools_send_receive_timeout_seconds        = 240

    frontend_endpoints     =  {
      ep1 = {
            name                                    = "my-frontdoor-frontend-endpoint"
            host_name                               = "my-frontdoor.azurefd.net"
            custom_https_provisioning_enabled       = false
            custom_https_configuration              = { certificate_source = "FrontDoor"}
            session_affinity_enabled                = false
            session_affinity_ttl_seconds            = 0
            waf_policy_link_id                      = ""
         }
     }

    frontdoor_routing_rule = {
        rule1={
                name               = "my-routing-rule"
                accepted_protocols = ["Http", "Https"] 
                patterns_to_match  = ["/*"]
                enabled            = true              
                configuration      = "Forwarding"
                forwarding_configuration = {
                    backend_pool_name                     = "backendBing"
                    cache_enabled                         = true       
                    cache_use_dynamic_compression         = false       
                    cache_query_parameter_strip_directive = "StripNone" 
                    custom_forwarding_path                = ""
                    forwarding_protocol                   = "MatchRequest"   
                }
        }
     }



    frontdoor_loadbalancer =  {
        lb1= {
                name                            = "loadbalancer"
                sample_size                     = 4
                successful_samples_required     = 2
                additional_latency_milliseconds = 0
            }
    }

    }
}











