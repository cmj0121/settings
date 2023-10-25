output "grafana_hostname" {
  description = "The hostname of the Grafana instance"
  value       = module.grafana.hostname
}

output "grafana_admin_username" {
  description = "The username of the Grafana instance"
  value       = module.grafana.admin_username
}

output "grafana_admin_password" {
  description = "The admin password for the Grafana instance"
  value       = module.grafana.admin_password
  sensitive   = true
}
