output "service_hostname" {
  description = "The service name of the Gitea service."
  value       = local.name
}

output "admin_password" {
  description = "The admin password for the Gitea instance"
  value       = random_password.password.result
  sensitive   = true
}
