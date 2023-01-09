  // Get Certificate from External source
resource "azurerm_app_service_certificate" "appcertificate" {

  for_each = {
    for key, value in try(var.appservice_bindings, {}) : key => value    
  }
 
         
  name                = each.value.certificate_name
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = local.resource_groups[each.value.resource_group_key].location
  pfx_blob            = filebase64("certificate.pfx") // TO-DO: CERTIFICATE NAME HAS TO BE A VARIABLE
  password            = "certificatepwd"
}

// Now bind the webapp to the domain. 
resource "azurerm_app_service_custom_hostname_binding" "appservice_bindings" {

  for_each = {
    for key, value in try(var.appservice_bindings, {}) : key => value    
  }

  
  depends_on = [
    azurerm_app_service_certificate.appcertificate    
  ]
  
  hostname            = each.value.hostname
  app_service_name    = module.appservice[each.value.app_key].app_service_name
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  # ssl_state           = each.value.ssl_state
  # thumbprint          = azurerm_app_service_certificate.appcertificate[each.key].thumbprint

   # azurerm_app_service_certificate_binding.example
  lifecycle {
    ignore_changes = [ssl_state, thumbprint]
  }
}
  
 // Now bind certificate to the webapp. 
resource "azurerm_app_service_certificate_binding" "bind_certificate_to_webapp" {
        for_each = {
           for key, value in try(var.appservice_bindings, {}) : key => value    
        }

      hostname_binding_id = azurerm_app_service_custom_hostname_binding.appservice_bindings[each.key].id
      ssl_state           = each.value.ssl_state
      certificate_id      = azurerm_app_service_certificate.appcertificate[each.key].id
    }