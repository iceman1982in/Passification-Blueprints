variable "resource_group_name" {
  type = string
}

variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "sku" {
  type = string
}

variable "admin_enabled"{
    type = string
}

variable "replication_location" {
  default     = {}
}