output "hostname" {
  description = "The hostname of the Redis service"
  value       = local.hostname
}

output "service_name" {
  description = "The name of the Redis service name"
  value       = "${local.name}-master.${var.namespace}"
}
