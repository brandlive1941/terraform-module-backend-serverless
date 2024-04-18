output "backend" {
  description = "Backend Details"
  value       = local.backend
}

output "services" {
  description = "Local Details"
  value       = local.cloud_run_services
}
