variable "hostname" {
  description = "The base hostname to use for the ingress"
  type        = string
}

variable "helm_version" {
  description = "The version of the external-dns Helm chart to use"
  type        = string
  default     = "1.13.1"
}

variable "pihole_service_name" {
  description = "The name of the Pi-hole service"
  type        = string
}

variable "pihole_admin_password" {
  description = "The admin password for the Pi-hole web interface"
  type        = string
}
