data "azurerm_resource_group" "networkrg" {
name = var.network_resource_group
}

data "azurerm_virtual_network" "mainnetwork" {
  name                =  var.virtual_network_name
  resource_group_name =  data.azurerm_resource_group.networkrg.name
}


data "azurerm_subnet" "vnetintegrationsubnet" {
   name                 = var.subnet_name
   resource_group_name  = data.azurerm_resource_group.networkrg.name
   virtual_network_name = data.azurerm_virtual_network.mainnetwork.name
}


resource "azurerm_app_service_virtual_network_swift_connection" "vnetintegrationconnection" {   
  app_service_id  =  var.app_service_id
  subnet_id       =  data.azurerm_subnet.vnetintegrationsubnet.id  
}