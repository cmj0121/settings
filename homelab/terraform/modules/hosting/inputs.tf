variable "hostname" {
  description = "The base hostname to use for the ingress"
  type        = string
}

variable "redis_host" {
  description = "The hostname of the Redis server"
  type        = string
  default     = "redis-master.storage.svc.cluster.local"
}

variable "redis_port" {
  description = "The port of the Redis server"
  type        = number
  default     = 6379
}
