variable "resource_group_name" {
  type = string
}

variable "name" {
  type = string
}

variable "private_link_enabled_resource_id" {
  type = string
}

variable "subresource_name" {
  description = "Private Endpoint Service Connection Sub Resource Name"
  type        = string
}
variable "network_resource_group"{
  type = string
}

variable "virtual_network_name" {
   type = string
}
  
variable "subnet_name" {
  type = string
}


variable "dns_zone_group_name" {
  type = string
}

variable "priv-dns-id"{

}



