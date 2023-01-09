
data "azurerm_private_dns_zone" "priv-dns" {
  // it has to be other provider:  
  name                =  var.private_dns_zone
  resource_group_name =  var.private_dns_zone_resource_group
}


