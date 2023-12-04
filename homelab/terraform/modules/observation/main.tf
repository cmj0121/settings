locals {
  namespace = "observation"
}

resource "kubernetes_namespace" "observation" {
  metadata {
    name = local.namespace
  }
}

module "grafana" {
  source    = "./grafana"
  hostname  = var.hostname
  namespace = kubernetes_namespace.observation.metadata[0].name
}

module "loki" {
  source    = "./loki"
  namespace = kubernetes_namespace.observation.metadata[0].name
}

module "tempo" {
  source    = "./tempo"
  namespace = kubernetes_namespace.observation.metadata[0].name
}
