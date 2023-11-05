locals {
  namespace = "monitoring"
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = local.namespace
  }
}

module "grafana" {
  source    = "./grafana"
  hostname  = var.hostname
  namespace = local.namespace
}

module "loki" {
  source    = "./loki"
  namespace = local.namespace
}
