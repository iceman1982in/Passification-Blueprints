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

  app = {
    name              = "ava-mod-poc-app-rg"
    enabled           = true
    reuse             = true // false => will deploy the resource ; true => if the resource group exists
    location          = "eastus2"
    naming_convention = "name_mask:{name}"
  }

  db = {
    name              ="ava-mod-poc-db-rg"
    enabled           = true
    reuse             = true // false => will deploy the resource ; true => if the resource group exists
    location          = "eastus2"
    naming_convention = "name_mask:{name}"
  }

}