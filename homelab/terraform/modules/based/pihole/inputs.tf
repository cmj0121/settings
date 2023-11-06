variable "hostname" {
  description = "The base hostname to use for the ingress"
  type        = string
}

variable "storage_class_name" {
  description = "The name of the storage class to use for the Redis PVC"
  type        = string
}
