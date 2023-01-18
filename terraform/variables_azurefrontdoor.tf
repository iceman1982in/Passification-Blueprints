variable "azure_frontdoors" {
     type        = map(any)
     description = "(Required) A list of azure_frontdoors with locations and tags"
    default     = {}
}
