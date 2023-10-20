output "grafana_admin_password" {
  description = "The admin password for the Grafana instance"
  value       = module.grafana.admin_password
  sensitive   = true
}
