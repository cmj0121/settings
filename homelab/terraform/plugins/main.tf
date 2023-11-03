locals {
  namespace = "plugins"
}

terraform {
  required_providers {
    gitea = {
      source  = "go-gitea/gitea"
      version = "0.3.0"
    }
  }
}

provider "gitea" {
  base_url = "http://${var.gitea_hostname}"

  # Username/Password authentication is mutally exclusive with token authentication
  username = var.gitea_admin_username
  password = var.gitea_admin_password
}

resource "kubernetes_namespace" "plugins" {
  metadata {
    name = local.namespace

    labels = {
      # inject istio sidecar
      istio-injection = "enabled"
    }
  }
}

module "drone" {
  source    = "./drone"
  hostname  = var.hostname
  namespace = local.namespace

  gitea_hostname     = var.gitea_hostname
  gitea_service_name = var.gitea_service_name
}
