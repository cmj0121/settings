output "hostname" {
  description = "The service name of the Grafana instance"
  value       = "${local.name}.${var.hostname}"
}

output "admin_password" {
  description = "The admin password for the Grafana instance"
  value       = random_password.password.result
}
