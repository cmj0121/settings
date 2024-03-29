output "hostname" {
  description = "The service name of the Grafana instance"
  value       = local.hostname
}

output "service_name" {
  description = "The service name of the Grafana instance"
  value       = "${local.name}.${var.namespace}"
}

output "admin_username" {
  description = "The admin username of the Grafana instance"
  value       = local.admin_username
}

output "admin_password" {
  description = "The admin password for the Grafana instance"
  value       = random_password.password.result
}
