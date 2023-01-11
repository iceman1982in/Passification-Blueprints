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

# // START ACR
dockerregistry={ 
    acr1 = {         
      name                     = "avamodpocacr" // TO-DO: how to follow naming convention?
      resource_group_key      =  "shared"       
      sku                      = "Premium"  // TO-DO: how to have a list of SKU availables ?
      admin_enabled            =  true      // TO-DO: What's this for?
  }
}


privateendpoint_dockerregistry= { 
     dockerregistryprd = {
      resource_group_key = "shared"     
      network_resource_group = "ava-mod-poc-network-rg" // TO-DO: how to change this to a DATA object or variable? 
      virtual_network_name="ava-mod-poc-vnet" // TO-DO: how to change to a DATA object or variable?
      subnet_name="default" // TO-DO: how to change to a DATA object or variable?
      name = "avamodpocacr-pe"  // TO-DO: how to follow naming convention
      key = "acr1" 
      dns_zone_group_name = "default" 
      private_dns_zone = "privatelink.azurecr.io" // TO-DO: how to change to DATA or variable?
      private_dns_zone_resource_group = "ava-mod-poc-dns-rg" // TO-DO: how to change to DATA or variable?
      subresource_name = "registry" // What's this for ?
  }
}
# // END ACR




# // START KEY VAULT
keyvaults = {
  kv1 = {
    naming_convention  = "name_mask:{name}"
    name               = "avamodpockeyvault" // TO-DO: naming convention
    enabled            = true
    resource_group_key = "shared"
    sku_name           = "standard" // TO-DO: options for SKU + Diff ? 
    location           = "eastus2" // TO-DO: from variable
  } 
}

privateendpoint_kv= {
  kvep1 = {
      resource_group_key = "shared"  // TO-DO: can we reuse the same resource group key from the keyvault itself? 
      network_resource_group = "ava-mod-poc-network-rg" //TO-DO: variables
      virtual_network_name="ava-mod-poc-vnet"
      subnet_name="default"
      name = "avamodpockeyvault-pe"
      key = "kv1"
      dns_zone_group_name = "default"
      private_dns_zone = "privatelink.vaultcore.azure.net" // TO-DO: how to change to DATA or variable
      private_dns_zone_resource_group = "ava-mod-poc-dns-rg" // TO-DO: how to change to DATA or variable
      subresource_name = "vault" // What's this for ? 
  }
}
# // END KEY VAULT


# // START STORAGE ACCOUNT
storageaccounts = {
  st1 = {
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

privateendpoint_storage = { //fill with respective client values
  strpe1={
      resource_group_key = "shared"    
      network_resource_group = "ava-mod-poc-network-rg" 
      virtual_network_name= "ava-mod-poc-vnet"
      subnet_name= "default"
      name = "avamodpocstorageaccount-pe"
      key = "st1"
      subresource_name = "blob"
      dns_zone_group_name = "default"
      private_dns_zone = "privatelink.blob.core.windows.net"
      private_dns_zone_resource_group = "ava-mod-poc-dns-rg"
  } 
}
# // END STORAGE ACCOUNT

# // START APIM
api_management = {
 api_m = {
        name                = "ava-mod-poc-apim"
        location            = "eastus2"
        resource_group_key = "shared"
        publisher_name      = "Avanade"
        publisher_email     = "s.vaz@avanade.com"
        sku_name            = "Developer_1" // TO-DO: What's the opptions and diff ? 
        tags                = ""
        additional_location = null  // What's this for ? 


        apim_products_subscription = { // TO-DO: Documentation/ Explanation
          apim_product1 = {
              product_id            = "training-people-product-std"
              product_display_name  = "PeopleStd"
              product_description   = "demo std"  
              subscription_state = "active"
              subscription_display_name = "sethu_sub1"   
          }
        }      
 }
}

# // END APIM


# // START APP SERVICE PLAN, INSIGHTS AND WEBAPPS
appserviceplans = {
  "appserviceplan-dev" = {
    name               = "ava-mod-poc-appserviceplan-dev"
    location           = "eastus2"
    resource_group_key = "app"
    kind               = "Windows" // TO-DO: Other options?
    size               = "S1" // TO-DO: Other Sizes?
    tier               = "standard" // TO-DO: Other Tiers ? 
  }
  "appserviceplanlinux-dev" = {
    name               = "ava-mod-poc-appserviceplanlinux-dev"
    location           = "eastus2"
    resource_group_key = "app"
    kind               = "Linux" // TO-DO: Other options?
    size               = "S1" // TO-DO: Other Sizes?
    tier               = "standard" // TO-DO: Other Tiers ? 
  }
}
application_insights = {
  appinsights = {
    name               = "ava-mod-poc-appinsights-dev"
    location           = "eastus2"
    resource_group_key = "app"
    application_type   = "web"
  }
}
appservice = {
  "app1" = {
    name               = "ava-mod-poc-webapp001-dev"
    location           = "eastus2"
    resource_group_key = "app"
    app_plan_id        = "appserviceplan-dev"
    app_insightskey   =   "appinsights"
    https_only = true
    vnet_route_all_enabled = true
  }

  "webjob" = {
    name               = "ava-mod-poc-webjob001-dev"
    location           = "eastus2"
    resource_group_key = "app"
    app_plan_id        = "appserviceplan-dev"
    app_insightskey   =   "appinsights"
    https_only = true
    vnet_route_all_enabled = true
  }  

  "linux1" = {
    name               = "ava-mod-poc-webapplinux001-dev"
    location           = "eastus2"
    resource_group_key = "app"
    app_plan_id        = "appserviceplanlinux-dev"
    app_insightskey   =   "appinsights"
    https_only = true
    vnet_route_all_enabled = true
  }

  "linuxwebjob" = {
    name               = "ava-mod-poc-webjoblinux001-dev"
    location           = "eastus2"
    resource_group_key = "app"
    app_plan_id        = "appserviceplanlinux-dev"
    app_insightskey   =   "appinsights"
    https_only = true
    vnet_route_all_enabled = true
  }  
}
// TO-DO: WORK WITH BINDINGS + AUTOMATION
# appservice_bindings={//fill with respective client values
#   binding1={
#        hostname = "{{clinet_hostname}}"
#        app_key = "app1"
#        resource_group_key = "app"
#        ssl_state  = "SniEnabled"   
#        certificate_name = "{{certificate_name}}"       
#   }
# }
appservice_vnetintegration= {//fill with respective client values
  app1 = {         
        network_resource_group = "ava-mod-poc-network-rg"
        virtual_network_name="ava-mod-poc-vnet"
        subnet_name="ava-mod-integration"
        webapp_key = "app1"
  }
  linux1 = {         
        network_resource_group = "ava-mod-poc-network-rg"
        virtual_network_name="ava-mod-poc-vnet"
        subnet_name="ava-mod-integration"
        webapp_key = "linux1"
  }
}
privateendpoint_appservice= {
  appserviceep1={
      resource_group_key = "app"    
      network_resource_group = "ava-mod-poc-network-rg"
      virtual_network_name="ava-mod-poc-vnet"
      subnet_name="default"
      name = "ava-mod-poc-webapp001-dev-pe"
      key = "app1"
      dns_zone_group_name = "default"
      private_dns_zone = "privatelink.azurewebsites.net"
      private_dns_zone_resource_group = "ava-mod-poc-dns-rg"
      subresource_name = "sites"
  }

  appservicelinuxep1={
      resource_group_key = "app"    
      network_resource_group = "ava-mod-poc-network-rg"
      virtual_network_name="ava-mod-poc-vnet"
      subnet_name="default"
      name = "ava-mod-poc-webapplinux001-dev-pe"
      key = "linux1"
      dns_zone_group_name = "default"
      private_dns_zone = "privatelink.azurewebsites.net"
      private_dns_zone_resource_group = "ava-mod-poc-dns-rg"
      subresource_name = "sites"
  }
}

keyvault_access_policies = {
    policy1= {
      keyvault_key= "kv1",
      app_key = "app1"
      enabled= true,   
      key_permissions: [
        "Get","List"
      ],
      secret_permissions: [        
        "List",
        "Get"        
      ]      
    }    
}
// APP SERVICE PLAN, INSIGHTS AND WEBAPPS 



# // START SQL SERVER
sql_server = {
  server1 = {
    name               = "ava-mod-poc-sqlserver-dev"
    location           = "eastus2"
    resource_group_key = "db"
    sqlversion         = "12.0"
    admin_username     = "sqadmin123"
    admin_password     = "Sqadmin#11122"
    tags               = ""
    public_network_access_enabled = false
    azuread_administrator  = {
          azuread_authentication_only = false
          login_username              = "s.vaz@avanade.com"
          object_id                   = "dd6e4bcf-6c60-4ec4-8066-3bab70eed33a" #value of object id 
          tenant_id                   = "5c7fbefe-6f52-4cab-bb0f-099dc2e314b9"  #tenant id 
    }
  }
}
sql_server_db = {
  db1 = {
    name                   = "avamodsqlservdb1"
    resource_group_key     = "db"
    location               = "eastus2"
    server_name            = "ava-mod-poc-sqlserver-dev"
    edition                = "Standard"
    service_objective_name = "S1"
    tags                   = ""
  } 
}
// END SQL SERVER

// START SQL SERVER MI

# sql_server_mi = {
#   server1 = {
#     name               = "ava-mod-poc-sqlservermi-dev"
#     location           = "eastus2"
#     resource_group_key = "db"
#     sqlversion         = "12.0"
#     admin_username     = "sqadmin123"
#     admin_password     = "Sqadmin#11122"
#     tags               = ""
#     vnet_name          = "ava-mod-poc-vnet"
#     vnet_rg            = "ava-mod-poc-network-rg"
#     subnet_name        = "ava-mod-poc-sqlmi-sn-001"
#     sku_name           = "GP_Gen5"
#     storage_size_in_gb = 32
#     sku_edition        = "GeneralPurpose"
#     vCores             = 8
#     license_type        = "LicenseIncluded"
#     hardwareFamily     = "Gen5"
#     tags               = ""
#     azuread_administrator  = {
#           azuread_authentication_only = false
#           login_username              = "s.vaz@avanade.com"
#           object_id                   = "dd6e4bcf-6c60-4ec4-8066-3bab70eed33a"
#           tenant_id                   = "5c7fbefe-6f52-4cab-bb0f-099dc2e314b9"
#     }
#   }
# }

# // to-do: sample DB for SQL Server MI:

# // END SQL SERVER MI


# // START MY SQL
mysql_server = {
  server1 = {
    name               = "ava-mod-poc-mysqlserver-dev"
    location           = "eastus"
    resource_group_key = "db"
    sqlversion         = "5.7"
    admin_username     = "sqadmin123"
    admin_password     = "Sqadmin#11122"
    sku_name   = "GP_Standard_D2ds_v4"  
    backup_retention_days             = 7
    geo_redundant_backup_enabled      = false  
    tags               = ""
    azuread_administrator  = {
          azuread_authentication_only = false
          login_username              = "s.vaz@avanade.com"
          object_id                   = "dd6e4bcf-6c60-4ec4-8066-3bab70eed33a" #value of object id 
          tenant_id                   = "5c7fbefe-6f52-4cab-bb0f-099dc2e314b9"  #tenant id 
    }
  }
}
mysql_server_db = {
  db1 = {
    name                   = "avamodmysqlservdb1"
    resource_group_key     = "db"    
    server_key            = "server1"
    charset             = "utf8"
    collation           = "utf8_unicode_ci"
  } 
}

# // END OF MYSQL SERVER