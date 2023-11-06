output "hostname" {
  description = "The service name of the Gitea service."
  value       = local.hostname
}

output "servicename" {
  description = "The service name of the Gitea service."
  value       = "${local.name}-http.${var.namespace}"
}

output "admin_username" {
  description = "The admin username for the Gitea instance"
  value       = local.admin_username
}

output "admin_password" {
  description = "The admin password for the Gitea instance"
  value       = random_password.password.result
  sensitive   = true
}
