
module "app_insights" {

  source = "../modules/apps/appinsights"

  for_each = {
    for key, value in try(var.application_insights, {}) : key => value
    //if try(value.enabled, false) == true
  }

  depends_on = [
    module.resource_groups    
  ]

  #   prefix                                = local.global_settings.prefix
  tags                                  = lookup(each.value, "tags", null)
  location                              = each.value.location
  resource_group_name                   = local.resource_groups[each.value.resource_group_key].name
  name                                  = lookup(each.value, "name", null)
  application_type                      = lookup(each.value, "application_type", "other")
  daily_data_cap_in_gb                  = lookup(each.value, "daily_data_cap_in_gb", null)
  daily_data_cap_notifications_disabled = lookup(each.value, "daily_data_cap_notifications_disabled", null)
  retention_in_days                     = lookup(each.value, "retention_in_days", "90")
  sampling_percentage                   = lookup(each.value, "sampling_percentage", null)
  disable_ip_masking                    = lookup(each.value, "disable_ip_masking", null)
  #   workspace_id                          = try(local.combined_objects_log_analytics[try(each.value.log_analytics_workspace.lz_key, local.client_config.landingzone_key)][each.value.log_analytics_workspace.key].id, null)
  #   global_settings                       = local.global_settings
  #   base_tags                             = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  #   diagnostic_profiles                   = try(each.value.diagnostic_profiles, null)
  #   diagnostics                           = local.combined_diagnostics
  #   settings                              = each.value
}


