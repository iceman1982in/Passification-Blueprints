resource "azurerm_linux_web_app" "app_service" {
  name                = var.app_service.name
  location            = var.app_service.location
  resource_group_name = var.resource_group_name
  service_plan_id     = var.app_plan_id

  site_config     {} //    = var.app_service.site_config

  app_settings        = var.app_service.app_settings

  //connection_string   = var.app_service.connection_string

  //identity            = var.app_service.identity

}

# resource "azurerm_linux_web_app_slot" "app_service_slot" {
#   name                = "${var.app_service.name}-swap"
#   app_service_id      = azurerm_linux_web_app.app_service.id
#   site_config     {} 
#   app_settings        = var.app_service.app_settings

#   #depends_on = [
#   #  module.resource_groups,
#   #  module.keyvault,

#   #]
#   #site_config {
#   #  java_version           = "1.8"
#   #  java_container         = "JETTY"
#   #  java_container_version = "9.3"
#   #}
# }