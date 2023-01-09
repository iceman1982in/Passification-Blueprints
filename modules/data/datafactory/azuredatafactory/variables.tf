variable "name" {
    default     = ""
}

variable "location" {
    default     = ""
}

variable "resource_group_name" {
    default     = ""
}

variable "public_network_enabled" {
    type= bool
    default = false
}

variable "managed_virtual_network_enabled"{
    type=bool
    default = true
}
