variable "hostname" {
  description = "The base hostname to use for the ingress"
  type        = string
}

variable "namespace" {
  description = "The k8s namespace to deploy the helm chart"
  type        = string
  default     = "default"
}

variable "storage_class_name" {
  description = "The name of the storage class to use for the Redis PVC"
  type        = string
  default     = "nfs-client"
}
