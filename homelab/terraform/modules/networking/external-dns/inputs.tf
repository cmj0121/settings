variable "hostname" {
  description = "The base hostname to use for the ingress"
  type        = string
}

variable "pihole_service_name" {
  description = "The name of the Pi-hole service"
  type        = string
}

variable "pihole_admin_password" {
  description = "The admin password for the Pi-hole web interface"
  type        = string
}
