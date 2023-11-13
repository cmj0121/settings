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

variable "gitea_act_runner_tokens" {
  description = "The set of tokens to create for the gitea action runner instance"
  type        = list(string)
  default     = []
}
