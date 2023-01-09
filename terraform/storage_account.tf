module "storage_account" {
    source = "../modules/storage_account"
  for_each = {
    for key, value in try(var.storageaccounts, {}) : key => value
    if try(value.enabled, false) == true
  }

  depends_on = [
    module.resource_groups
  ]
  //global_settings     = local.settings
  storage_account     = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  tags                = try(each.value.tags, null)
}



