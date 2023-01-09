
//naming 

resource "azurerm_app_service" "app_service" {
    name                = var.app_service.name
    location            = var.app_service.location
    resource_group_name = var.resource_group_name
    app_service_plan_id = var.app_plan_id


lifecycle {
    ignore_changes = [
      tags
    ]  
  }
    
}