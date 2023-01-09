#resource "azurerm_app_service_slot" "app_service_slot" {
#  name                = var.app_service.name + "_swap"
#  app_service_name    = var.app_service.name
#  location            = var.app_service.location
#  resource_group_name = var.resource_group_name
#  app_service_plan_id = var.app_plan_id

#  #site_config {
#  #  java_version           = "1.8"
#  #  java_container         = "JETTY"
#  #  java_container_version = "9.3"
#  #}
#}