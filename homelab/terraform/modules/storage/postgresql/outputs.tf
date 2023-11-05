output "hostname" {
  description = "The hostname of the PostgreSQL service"
  value       = local.hostname
}

output "service_name" {
  description = "The name of the PostgreSQL service name"
  value       = "${local.name}.${var.namespace}"
}

output "admin_password" {
  description = "The admin password of the PostgreSQL service"
  value       = random_password.password.result
  sensitive   = true
}
