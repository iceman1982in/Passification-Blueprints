resource azurerm_api_management "api_management"{

        name                = var.api_mgmt.name
        resource_group_name = var.resource_group_name
        location            = var.api_mgmt.location     
        publisher_name      = var.api_mgmt.publisher_name
        publisher_email     = var.api_mgmt.publisher_email
        sku_name            = var.api_mgmt.sku_name
        tags                = var.tags
        notification_sender_email = var.notification_sender_email
        zones                     = var.apim_zones

  dynamic "additional_location" {
                 for_each = var.additional_location != null ? [var.additional_location] : [] 
    content {
      location = additional_location.value.location
    }
  }

  dynamic "certificate" {
    for_each = var.certificate != null ? var.certificate : []

    content {
      encoded_certificate  = certificate.value.encoded_certificate
      certificate_password = certificate.value.certificate_password
      store_name           = certificate.value.store_name
    }
  }
  
  dynamic "identity" {
    for_each = var.identity != null ? [1] : []
    content {
      type = var.identity.identity_type
    }
  }

  dynamic "hostname_configuration" {
    for_each = var.hostname_configuration != null ? var.hostname_configuration : []

    content {
      dynamic "management" {
        for_each = hostname_configuration.value.management != null ? hostname_configuration.value.management : []

        content {
          host_name                    = management.value.host_name
          key_vault_id                 = management.value.key_vault_id
          certificate                  = management.value.certificate
          certificate_password         = management.value.certificate_password
          negotiate_client_certificate = management.value.negotiate_client_certificate
        }
      }
      dynamic "portal" {
        for_each = hostname_configuration.value.portal != null ? hostname_configuration.value.portal : []

        content {
          host_name                    = portal.value.host_name
          key_vault_id                 = portal.value.key_vault_id
          certificate                  = portal.value.certificate
          certificate_password         = portal.value.certificate_password
          negotiate_client_certificate = portal.value.negotiate_client_certificate
        }
      }
      dynamic "scm" {
        for_each = hostname_configuration.value.scm != null ? hostname_configuration.value.scm : []

        content {
          host_name                    = scm.value.host_name
          key_vault_id                 = scm.value.key_vault_id
          certificate                  = scm.value.certificate
          certificate_password         = scm.value.certificate_password
          negotiate_client_certificate = scm.value.negotiate_client_certificate
        }
      }
      dynamic "proxy" {
        for_each = hostname_configuration.value.proxy != null ? hostname_configuration.value.proxy : []

        content {
          default_ssl_binding          = proxy.value.default_ssl_binding
          host_name                    = proxy.value.host_name
          key_vault_id                 = proxy.value.key_vault_id
          certificate                  = proxy.value.certificate
          certificate_password         = proxy.value.certificate_password
          negotiate_client_certificate = proxy.value.negotiate_client_certificate
        }
      }
      dynamic "developer_portal" {
        for_each = hostname_configuration.value.developer_portal != null ? hostname_configuration.value.developer_portal : []

        content {
          host_name                    = developer_portal.value.host_name
          key_vault_id                 = developer_portal.value.key_vault_id
          certificate                  = developer_portal.value.certificate
          certificate_password         = developer_portal.value.certificate_password
          negotiate_client_certificate = developer_portal.value.negotiate_client_certificate
        }
      }
    }
  }
  dynamic "policy" {
    for_each = var.policy != null ? [1] : []

    content {
      xml_content = var.policy.xml_content
      xml_link    = var.policy.xml_link
    }
  }

  dynamic "protocols" {
    for_each = var.protocols != null ? [1] : []

    content {
      enable_http2 = var.protocols.enable_http2
    }
  }

  dynamic "security" {
    for_each = var.security != null ? [1] : []

    content {
      enable_backend_ssl30      = var.security.enable_backend_ssl30
      enable_backend_tls10      = var.security.enable_backend_tls10
      enable_backend_tls11      = var.security.enable_backend_tls11
      enable_frontend_ssl30     = var.security.enable_frontend_ssl30
      enable_frontend_tls10     = var.security.enable_frontend_tls10
      enable_frontend_tls11     = var.security.enable_frontend_tls11
      #enable_triple_des_ciphers = var.security.enable_triple_des_ciphers
    }
  }
  
  dynamic "sign_in" {
    for_each = var.sign_in != null ? [1] : []

    content {
      enabled = var.sign_in.enabled
    }
  }

   dynamic "sign_up" {
    for_each = var.sign_up != null ? [1] : []

    content {
      enabled = var.sign_up.enabled
      dynamic "terms_of_service" {
        for_each = var.sign_up.terms_of_service != null ? [1] : []

        content {
          consent_required = var.sign_up.terms_of_service.consent_required
          enabled          = var.sign_up.terms_of_service.enabled
          text             = var.sign_up.terms_of_service.text
        }
      }
    }
  }

  virtual_network_type = var.virtual_network_type
  dynamic "virtual_network_configuration" {
    for_each = var.virtual_network_configuration != null ? var.virtual_network_configuration : {}
    content {
      subnet_id = virtual_network_configuration.value.subnet_id
    }
  }
  timeouts {
    create = var.create_timeouts
    update = var.update_timeouts
    read   = var.read_timeouts
    delete = var.delete_timeouts
  }

   lifecycle {
                 ignore_changes = [virtual_network_type,virtual_network_configuration,certificate,zones]
                 }
}

resource "azurerm_api_management_product" "apim_product_creation" {
  for_each              = var.apim_products_subscription
  product_id            = each.value.product_id
  api_management_name   = azurerm_api_management.api_management.name
  resource_group_name   = var.resource_group_name
  display_name          = each.value.product_display_name
  description           = each.value.product_description
  subscription_required = true
  approval_required     = false
  published             = true
  depends_on            = [azurerm_api_management.api_management]
}

resource "azurerm_api_management_subscription" "apim_product_subscription_creation" {
  for_each            = var.apim_products_subscription
  api_management_name = azurerm_api_management.api_management.name
  resource_group_name = var.resource_group_name
  product_id          = azurerm_api_management_product.apim_product_creation[each.key].id
  state               = each.value.subscription_state
  display_name        = each.value.subscription_display_name
  depends_on          = [azurerm_api_management.api_management]
}