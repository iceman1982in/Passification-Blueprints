
resource "azurerm_service_plan" "app_plan" {  
      name                = var.app_plan.name
      location            = var.app_plan.location
      resource_group_name = var.resource_group_name      
      os_type             = var.app_plan.kind
      sku_name            = var.app_plan.size
     
       tags = try(var.app_plan.tags,null)
}

