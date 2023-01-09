# resource_groups = {
#   app = {
#     name              = "AVA-demo-DEV-APP-RG22"
#     enabled           = true
#     reuse             = true // whats the need for thiste
#     location          = "eastus"
#     naming_convention = "name_mask:{name}"
#   }
  
# }

# storageaccounts = {
#   st1 = {
#     enabled                  = true
#     name                     = "demo334234u23432"
#     resource_group_key       = "app"
#     location                 = "eastus"
#     account_tier             = "Standard"
#     access_tier              = "Hot"
#     account_replication_type = "LRS"
#     account_kind             = "StorageV2"
#   }
  

# }


# appserviceplans = {
#   "appservice-dev" = {
#     name               = "ddddddappplan1"
#     location           = "eastus"
#     resource_group_key = "app"
#     kind               = "windows"
#     size               = "S1"
#     tier               = "standard"
#   }

  
# }


# appservice = {
#   "app1" = {
#     name               = "ffgghh22"
#     location           = "eastus"
#     resource_group_key = "app"
#     app_plan_id        = "appservice-dev"

#   }

  
# }

# # webjobservice = {
# #   "job1" = {
# #     name                = "LTSWebJob"
# #     location            = "eastus"
# #     resource_group_key  = "app"  
# #     app_plan_id         = "appservice-dev"  

# #   }
# # }

# application_insights = {
#   webapp = {
#     name               = "tf-test-appinsights-web"
#     location           = "eastus"
#     resource_group_key = "app"
#     application_type   = "web"
#   }
# }

# sql_server = {
#   server1 = {
#     name               = "sqlltsdsds"
#     location           = "westus"
#     resource_group_key = "app"
#     sqlversion         = "12.0"
#     admin_username     = "sqadmin123"
#     admin_password     = "Sqadmin#11122"
#     tags               = ""
#   }
# }

# sql_server_db = {
#   db1 = {
#     name                   = "db1d"
#     resource_group_key     = "app"
#     location               = "westus"
#     server_name            = "sqllts56789994"
#     edition                = "Standard"
#     service_objective_name = "S1"
#     tags                   = ""
#   }


# }

# keyvaults = {
#   kv1 = {
#     naming_convention  = "name_mask:{name}"
#     name               = "AVA-KVsethuwww"
#     enabled            = true
#     resource_group_key = "app"
#     sku_name           = "standard"
#     location           = "eastus"
#   }

  
# }


# global_tags = {
#   Provisioner = "Terraform"
# }


