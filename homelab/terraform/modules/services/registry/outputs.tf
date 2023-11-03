output "hostname" {
  description = "The service name of the Registry"
  value       = local.hostname
}

output "servicename" {
  description = "The service name of the Gitea service."
  value       = "${local.name}.${var.namespace}"
}
