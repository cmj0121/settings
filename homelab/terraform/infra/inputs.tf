variable "hostname" {
  description = "The base hostname to use for the ingress"
  type        = string
  default     = "home.lab"
}

variable "storage_class_name" {
  description = "The name of the local storage class to use"
  type        = string
}

variable "local_storage_size" {
  description = "The size of the local storage to request"
  type        = string
  default     = "1Gi"
}

variable "local_storage_path" {
  description = "The path to the local storage to use"
  type        = string
}
