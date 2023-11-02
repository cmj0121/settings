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
