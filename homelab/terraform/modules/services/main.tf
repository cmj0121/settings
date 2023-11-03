locals {
  namespace = "services"
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = local.namespace

    labels = {
      # inject istio sidecar
      istio-injection = "enabled"
    }
  }
}

module "gitea" {
  source    = "./gitea"
  hostname  = var.hostname
  namespace = local.namespace
}

module "argocd" {
  source    = "./argocd"
  hostname  = var.hostname
  namespace = local.namespace
}
