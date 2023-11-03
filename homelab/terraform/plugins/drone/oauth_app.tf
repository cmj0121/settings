terraform {
  required_providers {
    gitea = {
      source  = "go-gitea/gitea"
      version = "0.3.0"
    }
  }
}

resource "gitea_oauth2_app" "drone-oauth-app" {
  name                = "drone-oauth-app"
  confidential_client = true
  redirect_uris = [
    "http://${local.hostname}/login",
  ]
}

resource "kubernetes_manifest" "gitea-service-entry" {
  manifest = yamldecode(templatefile("${path.module}/values/gitea-service-entry.yml", {
    namespace = var.namespace

    gitea_hostname     = var.gitea_hostname
    gitea_service_name = var.gitea_service_name
    gitea_service_port = var.gitea_service_port
  }))
}

resource "kubernetes_manifest" "registry-service-entry" {
  manifest = yamldecode(templatefile("${path.module}/values/registry-service-entry.yml", {
    namespace = var.namespace

    registry_hostname     = var.registry_hostname
    registry_service_name = var.registry_service_name
    registry_service_port = var.registry_service_port
  }))
}
