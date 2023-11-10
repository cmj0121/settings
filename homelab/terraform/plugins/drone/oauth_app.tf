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
  manifest = yamldecode(templatefile("${path.module}/values/service-entry.yml", {
    name      = "gitea-hostname-alias"
    namespace = var.namespace

    hostname     = var.gitea_hostname
    service_name = var.gitea_service_name
    service_port = var.gitea_service_port
  }))
}

resource "kubernetes_manifest" "registry-service-entry" {
  manifest = yamldecode(templatefile("${path.module}/values/service-entry.yml", {
    name      = "registry-hostname-alias"
    namespace = var.namespace

    hostname     = var.registry_hostname
    service_name = var.registry_service_name
    service_port = var.registry_service_port
  }))
}

resource "kubernetes_manifest" "drone-service-entry" {
  manifest = yamldecode(templatefile("${path.module}/values/service-entry.yml", {
    name      = "drone-hostname-alias"
    namespace = var.namespace

    hostname     = local.hostname
    service_name = "drone"
    service_port = 8080
  }))
}
