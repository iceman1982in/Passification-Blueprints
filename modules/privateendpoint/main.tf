 data "azurerm_resource_group" "main" {
  name = var.network_resource_group
}

data "azurerm_virtual_network" "main" {
  name                =  var.virtual_network_name
  resource_group_name =  data.azurerm_resource_group.main.name
}

data "azurerm_subnet" "main" {  
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = data.azurerm_virtual_network.main.name
}

resource "azurerm_private_endpoint" "endpoint" {
  name                = var.name
  location            = data.azurerm_resource_group.main.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.main.id

  private_service_connection {
    name                           = format("%s-%s", var.name, "privateserviceconn")
    private_connection_resource_id = var.private_link_enabled_resource_id
    is_manual_connection           = false
    subresource_names              = [var.subresource_name]
  }

  private_dns_zone_group {
    name                 =  var.dns_zone_group_name
    private_dns_zone_ids =  [var.priv-dns-id]
  }

   lifecycle {
    ignore_changes = [
      resource_group_name, location,tags
    ]
  }
}

