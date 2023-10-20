output "admin_password" {
  description = "The admin password for the Grafana instance"
  value       = random_password.password.result
}
