module "data_factory" {
  source = "../modules/data/datafactory/azuredatafactory"
  for_each = {
    for key, value in try(var.datafactory, {}) : key => value    
  }
  
  name                = each.value.name
  location            = local.resource_groups[each.value.resource_group_key].location
  resource_group_name = local.resource_groups[each.value.resource_group_key].name  
   managed_virtual_network_enabled = try(each.value.managed_virtual_network_enabled,true)
}




module "datafactory_runtime" {
  source = "../modules/data/datafactory/azuredatafactoryruntime"
  for_each = {
    for key, value in try(var.datafactoryruntime, {}) : key => value    
  }
    depends_on = [
        module.data_factory
     ]
  name            =  each.value.name
  data_factory_id =  module.data_factory[each.value.data_factory_id].id
  location        =  local.resource_groups[each.value.resource_group_key].location
  node_size = each.value.node_size 
  max_parallel_executions_per_node = try(each.value.max_parallel_executions_per_node,1)
  edition = each.value.edition
  network_resource_group  =  try(each.value.network_resource_group, null)
  virtual_network_name    = try(each.value.virtual_network_name, null)
  subnet_name             = try(each.value.subnet_name, null)
  blob_container_uri = "${data.azurerm_storage_account.adfstr.primary_blob_endpoint}/${azurerm_storage_container.adfctr.name}"
  sas_token          = data.azurerm_storage_account_blob_container_sas.sasctr.sas
}