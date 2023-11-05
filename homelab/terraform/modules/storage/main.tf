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
  source    = "./redis"
  namespace = kubernetes_namespace.storage.metadata[0].name
  hostname  = var.hostname
}

module "postgresql" {
  source    = "./postgresql"
  namespace = kubernetes_namespace.storage.metadata[0].name
  hostname  = var.hostname
}
