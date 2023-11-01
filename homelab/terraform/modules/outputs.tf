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

output "argocd_hostname" {
  description = "The hostname of the ArgoCD instance"
  value       = module.hosting.argocd_hostname
}

output "argocd_admin_password" {
  description = "The admin password for the ArgoCD instance"
  value       = module.hosting.argocd_admin_password
  sensitive   = true
}

output "pihole_admin_password" {
  description = "The admin password for the Pi-hole web interface"
  value       = module.networking.pihole_admin_password
  sensitive   = true
}
