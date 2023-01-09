module "docker_registry" {
  source = "../modules/docker/registry"
  for_each = {
    for key, value in try(var.dockerregistry, {}) : key => value    
  }

  name                     = each.value.name
  resource_group_name      = local.resource_groups[each.value.resource_group_key].name
  location                 = local.resource_groups[each.value.resource_group_key].location
  sku                      = each.value.sku
  admin_enabled            = each.value.admin_enabled
  
}