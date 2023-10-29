output "admin_password" {
  description = "The admin password for the Pi-hole web interface"
  value       = random_password.password.result
  sensitive   = true
}

output "service_name" {
  description = "The name of the Pi-hole service"
  value       = "${local.name}-web.${local.namespace}.svc.cluster.local"
}
