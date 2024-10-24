locals {
  name      = "storage"
  namespace = "storage"
}

resource "kubernetes_namespace" "storage" {
  metadata {
    name = local.namespace
  }
}

module "redis" {
  source       = "./redis"
  helm_version = "18.4.0"
  namespace    = kubernetes_namespace.storage.metadata[0].name
  hostname     = var.hostname
}
