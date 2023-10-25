output "gitea_hostname" {
  description = "The hostname of the Gitea instance"
  value       = module.gitea.hostname
}

output "gitea_admin_password" {
  description = "The admin password for the Gitea instance"
  value       = module.gitea.admin_password
  sensitive   = true
}
