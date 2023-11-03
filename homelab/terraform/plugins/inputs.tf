variable "hostname" {
  description = "The base hostname to use for the ingress"
  type        = string
}

variable "gitea_hostname" {
  description = "The hostname of the Gitea instance"
  type        = string
}

variable "gitea_service_name" {
  description = "The service name of the Gitea instance"
  type        = string
}

variable "gitea_admin_username" {
  description = "The username of the Gitea admin user"
  type        = string
}

variable "gitea_admin_password" {
  description = "The password of the Gitea admin user"
  type        = string
  sensitive   = true
}
