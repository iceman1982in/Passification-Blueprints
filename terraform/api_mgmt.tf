
module "api_management" {
  source = "../modules/apps/api_management"

  for_each = {
    for key, value in try(var.api_management, {}) : key => value
    //if try(value.enabled, false) == true
  }

  depends_on = [
    module.resource_groups    
  ]

  api_mgmt            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  apim_products_subscription = each.value.apim_products_subscription
  
}

