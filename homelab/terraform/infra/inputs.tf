variable "hostname" {
  description = "The base hostname to use for the ingress"
  type        = string
  default     = "home.lab"
}

variable "nfs_server" {
  description = "NFS server IP address"
  type        = string
}

variable "nfs_path" {
  description = "NFS server path"
  type        = string
}
