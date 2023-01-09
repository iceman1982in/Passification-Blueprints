
module "appservice_plan" {
  source = "../modules/apps/appserviceplan"

  for_each = {
    for key, value in try(var.appserviceplans, {}) : key => value
    //if try(value.enabled, false) == true
  }

  depends_on = [
    module.resource_groups,
    module.app_insights
  ]

  app_plan            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
}

