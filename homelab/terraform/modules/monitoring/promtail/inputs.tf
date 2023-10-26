variable "namespace" {
  description = "The k8s namespace to deploy the helm chart"
  type        = string
  default     = "default"
}

variable "loki_service_name" {
  description = "The k8s service name for loki"
  type        = string
}
