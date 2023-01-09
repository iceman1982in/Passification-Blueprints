variable "resource_group_name" {
  description = "The name of the resource group in which the resource is created"
  type        = string
}
variable "tags" {
  description = "Custom tags for the resource"
  default     = {}
}
variable "storage_account" {
  description = "Configuration settings object for the Storage Account resource"
}
variable "virtual_networks" {
  description = "Virtual Networks module object"
  default     = {}
}
variable "private_endpoints" {
  description = "Private Endpoints map settings object"
  default     = {}
}
variable "private_dns" {
  description = "Private DNS module object"
  default     = {}
}
variable "recovery_vaults" {
  description = "Recovery Vault module object"
  default     = {}
}
