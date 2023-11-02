output "grafana_hostname" {
  description = "The hostname of the Grafana instance"
  value       = module.monitoring.grafana_hostname
}

output "grafana_admin_username" {
  description = "The username of the Grafana instance"
  value       = module.monitoring.grafana_admin_username
}

output "grafana_admin_password" {
  description = "The admin password for the Grafana instance"
  value       = module.monitoring.grafana_admin_password
  sensitive   = true
}

output "pihole_admin_password" {
  description = "The admin password for the Pi-hole web interface"
  value       = module.networking.pihole_admin_password
  sensitive   = true
}
