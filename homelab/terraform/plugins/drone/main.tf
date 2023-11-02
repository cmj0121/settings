locals {
  name     = "drone"
  hostname = "${local.name}.${var.namespace}.${var.hostname}"
}

terraform {
  required_providers {
    gitea = {
      source  = "go-gitea/gitea"
      version = "0.3.0"
    }
  }
}
