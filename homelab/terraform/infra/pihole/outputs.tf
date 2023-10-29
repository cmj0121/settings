output "admin_password" {
  description = "The admin password for the Pi-hole web interface"
  value       = random_password.password.result
  sensitive   = true
}
