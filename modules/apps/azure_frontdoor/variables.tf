variable "frontdoor_resource_group_name" {
  description = "(Required) Resource Group name"
  type = string
}
 
variable "frontdoor_name" {
  description = "(Required) Name of the Azure Front Door to create"
  type = string
}
 
variable "frontdoor_loadbalancer_enabled" {
  description = "(Required) Enable the load balancer for Azure Front Door"
  type = bool
}
 
variable "enforce_backend_pools_certificate_name_check" {
  description = "Enforce the certificate name check for Azure Front Door"
  type = bool
  default = false
}
 
variable "backend_pools_send_receive_timeout_seconds" {
  description = "Set the send/receive timeout for Azure Front Door"
  type = number
  default = 60
}
 
variable "tags" {
  description = "(Required) Tags for Azure Front Door" 
}
 
variable "frontend_endpoints" {
  description = "(Required) Frontend Endpoints for Azure Front Door"
}
 
variable "routing_rules" {
  description = "(Required) Routing rules for Azure Front Door"
}
 
variable "backend_pool_load_balancing" {
  description = "(Required) Load Balancer settings for Azure Front Door"
}
 
variable "backend_pool_health_probes" {
  description = "(Required) Health Probe settings for Azure Front Door"
}
 
variable "backend_pools" {
  description = "(Required) Backend settings for Azure Front Door"
}