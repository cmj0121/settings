variable "hostname" {
  description = "The base hostname to use for the ingress"
  type        = string
}

variable "storage_class_name" {
  description = "The name of the storage class to use for the Redis PVC"
  type        = string
  default     = "local-usb-sc"
}

variable "pihole_version" {
  description = "The version of the pi-hole Helm chart to use"
  type        = string
  default     = "2.26.1"
}

variable "external_dns_version" {
  description = "The version of the external-dns Helm chart to use"
  type        = string
  default     = "1.15.0"
}
