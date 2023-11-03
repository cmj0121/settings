locals {
  name    = "promtail"
  version = "6.15.3"
}

resource "helm_release" "promtail" {
  name       = local.name
  repository = "https://grafana.github.io/helm-charts"
  chart      = local.name
  version    = local.version
  namespace  = var.namespace
}

resource "kubernetes_config_map" "promtail-config" {
  metadata {
    name = "promtail-config"
  }

  data = {
    "promtail.yml" = templatefile("${path.module}/promtail-config.yml", {
      loki_service_name = var.loki_service_name
    })
  }
}
