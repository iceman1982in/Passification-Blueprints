output "resource_group_name" {
  description = "The name of the resource group in which resources are created"
  value       = var.resource_group_name
}

output "resource_group_location" {
  description = "The location of the resource group in which resources are created"
  value       = var.location
}

output "id" {
  value = azurerm_mssql_managed_instance.primary.id
}