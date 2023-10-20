output "grafana_admin_password" {
  description = "The admin password for the Grafana instance"
  value       = module.monitoring.grafana_admin_password
  sensitive   = true
}
