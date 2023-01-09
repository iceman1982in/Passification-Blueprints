variable "api_mgmt" {
    description = "Configuration settings object for the App_service resource"  
}

variable "resource_group_name" {
  description = "The name of the resource group in which the resource is created"
  type        = string
}


variable "tags" {
  description = "(optional) User-Defined tags"
  type        = map(string)
  default     = {}
}

variable "certificate" {
  type = list(object({
    encoded_certificate  = string
    certificate_password = string
    store_name           = string
  }))
  default = null
}

variable "additional_location" {
  type = list(object({
    location = string
  }))
  default = null
}

variable "identity" {
  type = object({
    identity_type = string
  })
  default = {
    identity_type = "SystemAssigned"
  }
}

variable "hostname_configuration" {
  type = list(object({
    management = list(object({
      host_name                    = string
      key_vault_id                 = string
      certificate                  = string
      certificate_password         = string
      negotiate_client_certificate = bool
    }))

    portal = list(object({
      host_name                    = string
      key_vault_id                 = string
      certificate                  = string
      certificate_password         = string
      negotiate_client_certificate = bool
    }))

    scm = list(object({
      host_name                    = string
      key_vault_id                 = string
      certificate                  = string
      certificate_password         = string
      negotiate_client_certificate = bool
    }))

    proxy = list(object({
      default_ssl_binding          = bool
      host_name                    = string
      key_vault_id                 = string
      certificate                  = string
      certificate_password         = string
      negotiate_client_certificate = bool
    }))

    developer_portal = list(object({
      host_name                    = string
      key_vault_id                 = string
      certificate                  = string
      certificate_password         = string
      negotiate_client_certificate = bool
    }))

  }))
  default = null
}

variable "notification_sender_email" {
  type    = string
  default = null
}

variable "policy" {
  type = object({
    xml_content = string
    xml_link    = string
  })
  default = null
}

variable "protocols" {
  type = object({
    enable_http2 = bool
  })
  default = null
}

variable "security" {
  type = object({
    enable_backend_ssl30      = bool
    enable_backend_tls10      = bool
    enable_backend_tls11      = bool
    enable_frontend_ssl30     = bool
    enable_frontend_tls10     = bool
    enable_frontend_tls11     = bool
    enable_triple_des_ciphers = bool
  })
  default = null
}

variable "sign_in" {
  type = object({
    enabled = bool
  })
  default = null
}

variable "sign_up" {
  type = object({
    enabled = bool
    terms_of_service = object({
      consent_required = bool
      enabled          = bool
      text             = string
    })
  })
  default = null
}

variable "diag_object" {
  description = "(optional) Contains the diagnostics setting object. supports more than oe log a id"
  type = list(object({
    log_analytics_workspace_id = string
    log                        = list(tuple([string, bool, bool, number]))
    metric                     = list(tuple([string, bool, bool, number]))
  }))
  default = null
}

variable "virtual_network_configuration" {
  type = map(object({
    subnet_id = string
  }))
  default = null
}

variable "virtual_network_type" {
  default = "None"
}

variable "create_timeouts" {
  default = "3h"
}
variable "update_timeouts" {
  default = "3h"
}
variable "read_timeouts" {
  default = "3h"
}
variable "delete_timeouts" {
  default = "3h"
}

variable "dependencies" {
  type        = list(any)
  description = "List of dependecies modules or resources"
  default     = null
}

variable "application_insights_instrumentation_name" {
  type        = string
  description = "(Optional) Enable logging to app insights"
  default     = "app_insight01"
}


variable "application_insights_instrumentation_key" {
  type        = string
  description = "(Optional) Enable logging to app insights"
  default     = null
}

variable "key_vault_id" {
  type        = string
  description = "Key vault id for api management"
  default     = null
}

variable "apim_zones" {
  type = list(string)
  default = null
  description = "A list of availability zones"
}

variable "apim_products_subscription" {
  type = map(object({
    product_id = string
    product_display_name = string
    product_description = string
    subscription_state = string
    subscription_display_name = string
  }))
  default = null
  description = "APIM Product and Subscription info"
}