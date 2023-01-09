 data "azurerm_client_config" "current" {}

 module "keyvault_access_policies" {
  
    source     =  "../modules/security/keyvault_access_policies"
    depends_on = [module.keyvault , module.appservice]
    for_each = {
        for key, value in try(var.keyvault_access_policies, {}) : key => value    
      }

    keyvault_id =  module.keyvault[each.value.keyvault_key].id
    access_policy = each.value
    tenant_id     = var.tenant_id
    object_id     = module.appservice[each.value.app_key].app_service_identity_service_principal_id
 }