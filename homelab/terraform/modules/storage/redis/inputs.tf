variable "hostname" {
  description = "The base hostname to use for the ingress"
  type        = string
}

variable "helm_version" {
  description = "The version of the Helm chart to deploy"
  type        = string
}

variable "namespace" {
  description = "The k8s namespace to deploy the helm chart"
  type        = string
  default     = "default"
}
