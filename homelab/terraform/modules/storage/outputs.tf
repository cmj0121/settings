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

output "postgresql_hostname" {
  description = "The hostname of the PostgreSQL service"
  value       = module.postgresql.hostname
}

output "postgresql_service_name" {
  description = "The name of the PostgreSQL service name"
  value       = module.postgresql.service_name
}

output "postgresql_admin_password" {
  description = "The admin password of the PostgreSQL service"
  value       = module.postgresql.admin_password
  sensitive   = true
}

output "mariadb_hostname" {
  description = "The hostname of the PostgreSQL service"
  value       = module.mariadb.hostname
}

output "mariadb_service_name" {
  description = "The name of the PostgreSQL service name"
  value       = module.mariadb.service_name
}

output "mariadb_admin_password" {
  description = "The admin password of the PostgreSQL service"
  value       = module.mariadb.admin_password
  sensitive   = true
}
