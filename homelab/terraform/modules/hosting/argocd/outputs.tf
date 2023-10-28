output "hostname" {
  description = "The service name of the ArgoCD server"
  value       = "${local.name}.${var.namespace}.${var.hostname}"
}

output "admin_password" {
  description = "The admin password for the ArgoCD instance"
  value       = random_password.password.result
  sensitive   = true
}
