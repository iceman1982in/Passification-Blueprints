output "resource_group_name" {
  description = "The name of the resource group in which resources are created"
  value       = var.resource_group_name
}

output "resource_group_location" {
  description = "The location of the resource group in which resources are created"
  value       = var.location
}

output "id" {
  value = azurerm_mysql_flexible_server.primary.id
}

output "name" {
  description = "The Name of the Data Resource Group"
  value       = azurerm_mysql_flexible_server.primary.name
}