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

output "gitea_hostname" {
  description = "The hostname of the Gitea instance"
  value       = module.hosting.gitea_hostname
}

output "gitea_admin_username" {
  description = "The username of the Gitea instance"
  value       = module.hosting.gitea_admin_username
}

output "gitea_admin_password" {
  description = "The hostname of the Gitea instance"
  value       = module.hosting.gitea_admin_password
  sensitive   = true
}
