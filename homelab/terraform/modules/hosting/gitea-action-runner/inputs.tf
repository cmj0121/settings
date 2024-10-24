variable "namespace" {
  description = "The k8s namespace to deploy the helm chart"
  type        = string
  default     = "default"
}

variable "storage_class_name" {
  description = "The name of the storage class to use for the Redis PVC"
  type        = string
}

variable "gitea_service" {
  description = "The gitea service to connect to"
  type        = string
}

variable "gitea_act_runner_tokens" {
  description = "The set of tokens to create for the gitea action runner instance"
  type        = list(string)
  default     = []
}
