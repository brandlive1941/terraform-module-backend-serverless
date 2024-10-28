/******************************************
	Variables for Load Balancer
 *****************************************/

variable "project_id" {
  type        = string
  description = "GCP Project ID where the loadbalancer will be created"
}

variable "name" {
  type        = string
  description = "Name for backend"
}

variable "cloud_run_services" {
  description = "Cloud Run Service"
  type = list(object({
    region = string
    name   = string
  }))
}

variable "public" {
  description = "Whether the cloud run service should will recieve traffic from external load balancer"
  type        = bool
  default     = true
}

variable "enable_cdn" {
  description = "Enable CDN for the backend"
  type        = bool
  default     = false
}

variable "default_custom_error_response_policy" {
  description = "Default custom error response policy"
  type = object({
    custom_error_responses = optional(list(object({
      match_response_code    = optional(string)
      path                   = optional(string)
      override_response_code = optional(string)
    })))
    error_service = optional(string)
  })
  default = {
    custom_error_responses = null
    error_service          = null
  }
}

variable "log_config" {
  description = "Log Configuration"
  type = object({
    enable      = optional(bool)
    sample_rate = optional(number)
  })
  default = {
    enable      = null
    sample_rate = null
  }
}

variable "iap_config" {
  description = "IAP Configuration"
  type = object({
    enable               = bool
    oauth2_client_id     = optional(string)
    oauth2_client_secret = optional(string)
  })
  default = {
    enable               = false
    oauth2_client_id     = null
    oauth2_client_secret = null
  }
}