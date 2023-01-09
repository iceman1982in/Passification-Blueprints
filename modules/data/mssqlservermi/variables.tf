
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

variable "sqlversion" {
    default     = ""
}

variable "sqlserver_name" {
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

variable "minimum_tls_version" {
  description = ""
  default     = "1.2"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "vnet_name" {
  description   = "Vnet name where the sql instance will be deployed"
  type          = string
  default       = ""
}

variable "vnet_rg" {
  description   = "Vnet resource group name"
  type          = string
  default       = ""
}

variable "subnet_name" {
    description = "Subnet name where the sql instance will be deployed"
    type        = string
    default     = ""
}

variable "azuread_administrator" {
  type        = map(any)
}

variable "storage_size_in_gb" {
  description = "The password associated with the admin_username user"
  default     = null
}

variable "license_type" {
  description = "The license_type associated "
  default     = null
}

variable "vcores" {
  description = "The vcores associated "
  default     = 5
}

variable "sku_name" {
  description = "The sku_name associated "
  default     = ""
}


