
data "azurerm_subscription" "current" {
}

module "keyvault" {
  source = "../modules/security/keyvault"
  for_each = {
    for key, value in try(var.keyvaults, {}) : key => value
    // if try(value.enabled, false) == true
  }

  depends_on = [
    module.resource_groups
  ]
  //global_settings     = local.settings
  key_vault           = each.value
  tenant_id           = var.tenant_id //data.azurerm_subscription.current.tenant_id   //
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  tags                = try(each.value.tags, null)
}

# module "keyvault_access_policies" {
#   depends_on = [module.keyvault]
#   source     =  "../../../Modules/security/keyvault_access_policies"
#   count      = try(var.keyvault_access_policies, null) == null ? 0 : 1

#   keyvaults       = module.keyvault
#   tenant_id       = var.tenant_id
#   subscription_id = var.subscription_id
#   access_policies = try(var.keyvault_access_policies, {})
# }
