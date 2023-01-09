variable "resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
  default     = ""
}

variable "database_name" {
    default     = ""
}

variable "sql_servername" {
   default     = ""
}

variable "charset" {
   default     = ""
}
variable "collation" {
  default     = ""
}
variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

