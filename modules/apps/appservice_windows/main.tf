
resource "azurerm_windows_web_app" "app_service" {
  name                = var.app_service.name
  location            = var.app_service.location
  resource_group_name = var.resource_group_name
  service_plan_id     = var.app_plan_id
  https_only          = var.app_service.https_only

  site_config{
   vnet_route_all_enabled = var.app_service.vnet_route_all_enabled
  } 

 identity {
    type = "SystemAssigned"
  }

  app_settings = {
      
      "MSDEPLOY_RENAME_LOCKED_FILES"                    = "1"
      "WEBSITE_HEALTHCHECK_MAXPINGFAILURES"             = "10"      
      "APPINSIGHTS_INSTRUMENTATIONKEY"                  = var.app_insights.instrumentation_key
      "APPLICATIONINSIGHTS_CONNECTION_STRING"           = var.app_insights.connection_string
      "APPINSIGHTS_PROFILERFEATURE_VERSION"             = "1.0.0"
      "APPINSIGHTS_SNAPSHOTFEATURE_VERSION"             = "1.0.0"
      "ApplicationInsightsAgent_EXTENSION_VERSION"      = "~2"
      "DiagnosticServices_EXTENSION_VERSION"            = "~3"
      "InstrumentationEngine_EXTENSION_VERSION"         = "disabled"
      "SnapshotDebugger_EXTENSION_VERSION"              = "disabled"
      "XDT_MicrosoftApplicationInsights_BaseExtensions" = "disabled"
      "XDT_MicrosoftApplicationInsights_Java"           = "1"
      "XDT_MicrosoftApplicationInsights_Mode"           = "recommended"
      "XDT_MicrosoftApplicationInsights_NodeJS"         = "1"
      "XDT_MicrosoftApplicationInsights_PreemptSdk"     = "disabled"
    }


    logs {
      detailed_error_messages = false
      failed_request_tracing  = false
      application_logs {
        file_system_level = "Error"     
      }   
  }

  //connection_string   = var.app_service.connection_string
  //identity            = var.app_service.identity

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
            tags,connection_string,app_settings,logs,virtual_network_subnet_id
    ]
  }

}

