output "pihole_admin_password" {
  description = "The admin password for the Pi-hole web interface"
  value       = module.pihole.admin_password
  sensitive   = true
}
