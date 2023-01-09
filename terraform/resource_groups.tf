module "resource_groups" {
   source = "../modules/resourcegroup"
 for_each = {
    for key, value in try(var.resource_groups, {}) : key => value
    if try(value.reuse, false) == true && try(value.enabled, false) == true
  }
  resource_group_name     = each.value.name
  resource_group_location = each.value.location
  tags                    = try(each.value.tags, null)
}

module "resource_group_reused" {
    source = "../modules/resourcegroup_reused"

  depends_on = [
    module.resource_groups
  ]
   for_each = {
    for key, value in try(var.resource_groups, {}) : key => value
    if try(value.reuse, false) == true && try(value.enabled, false) == true
  }
  settings = each.value
}

