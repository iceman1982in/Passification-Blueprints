module "appservice_vnetintegration" {
  
  source = "../modules/apps/appservice_vnetintegration"

    for_each = {
      for key, value in try(var.appservice_vnetintegration, {}) : key => value    
    }

     depends_on = [
        module.appservice_plan,
        module.appservice
      ]

    app_service_id          = module.appservice[each.value.webapp_key].app_service_id             
    network_resource_group  = try(each.value.network_resource_group,null)
    virtual_network_name    = try(each.value.virtual_network_name,null)
    subnet_name             = try(each.value.subnet_name,null)
    
}