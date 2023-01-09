variable "resource_groups" {
  type        = map(any)
  description = "(Required) A list of Azure Resource Groups with locations and tags"
}

variable "dockerregistry" {
    type        = map(any)
    description = "(Optional) A list of docker registry"
    default     = {}
}

variable "privateendpoint_dockerregistry"{
  type        = map(any)
  description = "(Optional) A list of Private endpoints"
  default     = {}
}


variable "keyvaults" {
  type        = map(any)
  description = "(Optional) A list of Azure sql_server with locations and tags"
    default     = {}
}
variable "privateendpoint_kv"{
  type        = map(any)
  description = "(Optional) A list of Private endpoints"
  default     = {}
}


variable "storageaccounts" {
  type        = map(any)
  description = "(Required) A list of Azure Resource Groups with locations and tags"
  default     = {}
}
variable "privateendpoint_storage"{
  type        = map(any)
  description = "(Optional) A list of Private endpoints"
  default     = {}
}


variable "api_management" {
    type        = map(any)
  description = "(Required) A list of Azure api mgmt with locations and tags"
  default     = {}
}


variable "appserviceplans" {
  type        = map(any)
  description = "(Required) A list of Azure Resource Groups with locations and tags"
  default     = {}
}

variable "application_insights" {
  type        = map(any)
  description = "(Required) A list of Azure application_insights with locations and tags"
  default     = {}
}

variable "appservice" {
  type        = map(any)
  description = "(Required) A list of Azure appservice with locations and tags"
  default     = {}
}
variable "appservice_bindings"{
  type        = map(any)
  description = "(Optional) A list of app service bindings"
  default     = {}
}
variable "appservice_vnetintegration"{
  type        = map(any)
  description = "(Optional) A list of app service integraion"
  default     = {}
}
variable "privateendpoint_appservice"{
  type        = map(any)
  description = "(Optional) A list of Private endpoints"
  default     = {}
}

variable "keyvault_access_policies" {
  type        = map(any)
  description = "(Optional) A list of KV policy"
    default     = {}
}


variable "sql_server" {
  type        = map(any)
  description = "(Required) A list of Azure sql_server with locations and tags"
  default     = {}
}
variable "privateendpoint_sql"{
  type        = map(any)
  description = "(Optional) A list of Private endpoints"
  default     = {}
}

variable "sql_server_db" {
  type        = map(any)
  description = "(Required) A list of Azure sql_server with locations and tags"
  default     = {}
}

variable "sql_server_mi" {
  type        = map(any)
  description = "(Optional) A list of Azure sql_server managed instance with locations and tags"
  default     = {}
}



variable "mysql_server" {
  type        = map(any)
  description = "(Required) A list of Azure sql_server with locations and tags"
  default     = {}
}

variable "mysql_server_db"{
  type        = map(any)
  description = "(Required) A list of Azure sql_server with locations and tags"
  default     = {}
}



variable "datafactory" {
    type        = map(any)
    description = "(Optional) A list of datafactory"
    default     = {}
}

variable "datafactoryruntime" {
    type        = map(any)
    description = "(Optional) A list of datafactoryruntime"
    default     = {}
}


variable "privateendpoint_adf"{
  type        = map(any)
  description = "(Optional) A list of Private endpoints"
  default     = {}
}


variable "startupsettingsadf" {
  type        = map(any)
  description = "(Optional) A map of tags to be applied globally on all Azure resource groups"
}




variable "global_tags" {
  type        = map(any)
  description = "(Optional) A map of tags to be applied globally on all Azure resource groups"
  default     = {}
}

variable "subscription_core_id" {
  description = "Azure Subscription ID for the current deployment."
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID for the current deployment."
  type        = string
}

variable "tenant_id" {
  description = "Azure AD Tenant ID for the current deployment."
  type        = string
}


variable "resource_group_name" {
  type    = string 
  default = "AVA-APP-RG"
}


