variable "resource_group_name" {
  description = "The name of the resource group in which the resource is created"
  type        = string
}
variable "tags" {
  description = "Custom tags for the resource"
  default     = {}
}
variable "resource_group_location" {
  description = "Configuration settings object for the Resource Group resource"
}
