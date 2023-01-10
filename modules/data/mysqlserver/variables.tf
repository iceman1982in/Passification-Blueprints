
variable "resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
  default     = ""
}

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  default     = ""
}

variable "random_password_length" {
  description = "The desired length of random password created by this module"
  default     = 32
}

variable "mysqlversion" {
    default     = ""
}

variable "mysqlserver_name" {
  description = "SQL server Name"
  default     = ""
}

variable "admin_username" {
  description = "The administrator login name for the new SQL Server"
  default     = null
}

variable "admin_password" {
  description = "The password associated with the admin_username user"
  default     = null
}

variable "backup_retention_days"{
   default     = 7
}

variable "auto_grow_enabled"{
 default     = true
}

variable "geo_redundant_backup_enabled"{
 default     = false
}

variable "infrastructure_encryption_enabled"{
 default     = false
}

variable "public_network_access_enabled"{
 default     = true
}

variable "ssl_enforcement_enabled"{
 default     = true
}

variable "ssl_minimal_tls_version_enforced"{
 default     = "TLS1_2"
}

variable "storage_size_in_mb" {  
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "azuread_administrator" {
  type        = map(any)
}

variable "sku_name" {
  description = "The sku_name associated "
  default     = ""
}