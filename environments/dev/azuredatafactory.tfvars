# // START DATA FACTORY

# datafactory = {
#   factory1 = {
#         name = "ava-mod-poc-datafactory-adf"
#         resource_group_key = "shared" 
#         public_network_enabled = false 
#         managed_virtual_network_enabled = true 
#   }
# }

# datafactoryruntime = {
#   factory1 = {
#       name =  "ava-azure-integrationruntime" 
#       data_factory_id = "factory1"    
#       node_size = "Standard_D2_v3"
#       resource_group_key="shared"
#       network_resource_group = "ava-mod-poc-network-rg"
#       virtual_network_name="ava-mod-poc-vnet"
#       subnet_name="ava-mod-integrationruntime-adf"            
#       edition ="Enterprise"
   
#   }
# }

# privateendpoint_adf= {
#   adf1={
#       resource_group_key = "shared"    
#       network_resource_group = "ava-mod-poc-network-rg"
#       virtual_network_name="ava-mod-poc-vnet"
#       subnet_name="default"
#       name = "ava-mod-poc-datafactory-adf-pe"
#       key = "factory1"
#       dns_zone_group_name = "ava-mod-dns-rg"
#       private_dns_zone = "privatelink.datafactory.azure.net"
#       private_dns_zone_resource_group = "ava-mod-poc-dns-rg"
#       subresource_name = "dataFactory"
#   }
# }

# startupsettingsadf = {

#   storage_name = "avamodpocstorageaccount"
#   storage_container= "adfsetupfiles"
#   resource_group_key="shared"
#   container_access_type = "private"
#   start  = "2022-10-15"
#   expiry = "2023-10-21"

# }
# // END DATA FACTORY