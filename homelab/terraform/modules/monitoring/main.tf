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

module "promtail" {
  source            = "./promtail"
  namespace         = local.namespace
  loki_service_name = module.loki.service_name
}
