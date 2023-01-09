
module "appservice" {
  source = "../modules/apps/appservice_windows"

  for_each = {
    for key, value in try(var.appservice, {}) : key => value
    //if try(value.enabled, false) == true
  }

  depends_on = [
    module.resource_groups,
    module.appservice_plan
  ]

  app_service         = each.value
  app_plan_id         = local.appserviceplans[each.value.app_plan_id].app_service_plan_id
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  app_insights        = module.app_insights[each.value.app_insightskey]
  
}




