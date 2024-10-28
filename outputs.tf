output "backend" {
  description = "Backend Details"
  value       = local.backend
}

output "services" {
  description = "Local Details"
  value       = local.cloud_run_services
}

output "default_custom_error_response_policy" {
  description = "Default custom error response policy"
  value       = var.default_custom_error_response_policy
}