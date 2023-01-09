 data "azurerm_resource_group" "mainnwrg" {
  name = var.network_resource_group
}

data "azurerm_virtual_network" "mainnw" {
  name                =  var.virtual_network_name
  resource_group_name =  data.azurerm_resource_group.mainnwrg.name
}

data "azurerm_subnet" "mainsubnet" {  
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.mainnwrg.name
  virtual_network_name = data.azurerm_virtual_network.mainnw.name
}

resource "azurerm_data_factory_integration_runtime_azure_ssis" "example" {
  name            =  var.name
  data_factory_id =  var.data_factory_id
  location        =  var.location
  node_size = var.node_size

  max_parallel_executions_per_node = var.max_parallel_executions_per_node  
  edition = var.edition

  express_vnet_integration  {
      subnet_id = data.azurerm_subnet.mainsubnet.id
  }

  custom_setup_script {
      blob_container_uri = var.blob_container_uri
      sas_token          = var.sas_token
    }
}

