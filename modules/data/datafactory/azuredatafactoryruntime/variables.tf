variable "name" {
    default     = ""
}

variable "location" {
    default     = ""
}

variable "data_factory_id" {
    default     = ""
}

variable "node_size" {
    default     = ""
}

variable "max_parallel_executions_per_node"{
    default = 1
}


variable "edition"{
     default     = "Standard"
}

variable "subnet_id"{
     default  = ""
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

variable "sas_token" {
  type = string
}

variable "blob_container_uri" {
  type = string
}






