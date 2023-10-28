locals {
  namespace = "hosting"
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = local.namespace
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
