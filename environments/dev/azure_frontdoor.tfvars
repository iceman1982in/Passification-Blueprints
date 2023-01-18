subscription_id = "fb6eefcf-89bb-4ee1-8690-a799d5eb008e"
tenant_id       = "5c7fbefe-6f52-4cab-bb0f-099dc2e314b9" 
subscription_core_id = "fb6eefcf-89bb-4ee1-8690-a799d5eb008e" // TO-DO: Had to add but isn't being used in the pipeline
 
resource_groups = {
  # network = {
  #   name              = "ava-mod-poc-network-rg"
  #   enabled           = true
  #   reuse             = true // false => will deploy the resource ; true => if the resource group exists
  #   location          = "eastus2" // TO-DO: - how to move this to a variable or when reuse is true ignore this ? 
  #   naming_convention = "name_mask:{name}" // TO-DO: - how to apply naming convention in all resources?
  # }

  # dns = {
  #   name              = "ava-mod-poc-dns-rg"
  #   enabled           = true
  #   reuse             = true // false => will deploy the resource ; true => if the resource group exists
  #   location          = "eastus2" // TO-DO: - how to move this to a variable or when reuse is true ignore this ? 
  #   naming_convention = "name_mask:{name}" // TO-DO: - how to apply naming convention in all resources?
  # }

  shared = {
    name              = "ava-mod-poc-shared-rg"
    enabled           = true
    reuse             = true // false => will deploy the resource ; true => if the resource group exists
    location          = "eastus2" // TO-DO: - how to move this to a variable ?
    naming_convention = "name_mask:{name}" // TO-DO: - how to apply naming convention in all resources?
  }  
}


azure_frontdoors = {
  frontdoor1 = {
    enabled                  = true
    name                     = "avamodpocstorageaccount"
    resource_group_key       = "shared"
    location                 = "eastus2"
    account_tier             = "Standard"
    access_tier              = "Hot"
    account_replication_type = "LRS"
    account_kind             = "StorageV2"
  }
}











