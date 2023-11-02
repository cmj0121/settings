variable "hostname" {
  description = "The base hostname to use for the ingress"
  type        = string
}

variable "namespace" {
  description = "The k8s namespace to deploy the helm chart"
  type        = string
  default     = "default"
}
