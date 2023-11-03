variable "hostname" {
  description = "The base hostname to use for the ingress"
  type        = string
}

variable "namespace" {
  description = "The namespace to deploy into"
  type        = string
}

variable "gitea_hostname" {
  description = "The hostname of the Gitea instance"
  type        = string
}

variable "gitea_service_name" {
  description = "The service name of the Gitea instance"
  type        = string
}

variable "gitea_service_port" {
  description = "The service port of the Gitea instance"
  type        = string
  default     = 3000
}
