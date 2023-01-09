
# module "diagnostics" {
#   for_each               = var.diag_object == null ? {} : { 1 = 1 }
#   source                 = "../iac-tf-module-az-diagnostic-settings"
#   diag_object            = var.diag_object
#   resource_id            = azurerm_api_management.api_management.id
#   naming_convention_info = var.naming_convention_info
#   resource_type          = "apimdia"
#   tags                   = var.tags
# }



resource "azurerm_api_management_logger" "apim_logger_obj" {
  for_each            = var.application_insights_instrumentation_key == null ? {} : { 1 = 1 }
  name                = var.application_insights_instrumentation_name
  api_management_name = azurerm_api_management.api_management.name
  resource_group_name = azurerm_api_management.api_management.resource_group_name
  application_insights {
    instrumentation_key = var.application_insights_instrumentation_key
  }
}

resource "azurerm_api_management_diagnostic" "apim_diagnostics_obj" {
  for_each                 = var.application_insights_instrumentation_key == null ? {} : { 1 = 1 }
  identifier               = "applicationinsights"
  api_management_name      = azurerm_api_management.api_management.name
  resource_group_name      = azurerm_api_management.api_management.resource_group_name
  api_management_logger_id = azurerm_api_management_logger.apim_logger_obj[1].id
}