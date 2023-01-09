output "id" {
  description = "The id of the resource group."
  value       = azurerm_resource_group.rg.id
}

output "name" {
  description = "The Name of the Resource Group"
  value       = azurerm_resource_group.rg.name
}

output "location" {
  description = "The Location of the Resource Group"
  value       = azurerm_resource_group.rg.location
}

output "tags" {
  description = "The Tags of the Resource Group"
  value       = azurerm_resource_group.rg.tags
}
