output "redis_hostname" {
  description = "The hostname of the Redis service"
  value       = module.redis.hostname
}

output "redis_service_name" {
  description = "The name of the Redis service name"
  value       = module.redis.service_name
}

output "redis_admin_password" {
  description = "The admin password of the Redis service"
  value       = module.redis.admin_password
  sensitive   = true
}
