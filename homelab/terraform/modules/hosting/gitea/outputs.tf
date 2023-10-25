output "hostname" {
  description = "The service name of the Gitea service."
  value       = "${local.name}.${var.namespace}.${var.hostname}"
}

output "admin_password" {
  description = "The admin password for the Gitea instance"
  value       = random_password.password.result
  sensitive   = true
}
