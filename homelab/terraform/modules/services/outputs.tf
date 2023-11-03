output "gitea_hostname" {
  description = "The hostname of the Gitea instance"
  value       = module.gitea.hostname
}

output "gitea_service_name" {
  description = "The service name of the Gitea instance"
  value       = module.gitea.servicename
}

output "gitea_admin_username" {
  description = "The username of the Gitea instance"
  value       = module.gitea.admin_username
}

output "gitea_admin_password" {
  description = "The admin password for the Gitea instance"
  value       = module.gitea.admin_password
  sensitive   = true
}

output "argocd_hostname" {
  description = "The hostname of the ArgoCD instance"
  value       = module.argocd.hostname
}

output "argocd_admin_password" {
  description = "The admin password for the ArgoCD instance"
  value       = module.argocd.admin_password
  sensitive   = true
}
