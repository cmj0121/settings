locals {
  name    = "loki"
  version = "5.35.0"
}

resource "helm_release" "loki" {
  name       = local.name
  repository = "https://grafana.github.io/helm-charts"
  chart      = local.name
  version    = local.version
  namespace  = var.namespace

  values = ["${file("${path.module}/values.yml")}"]
}
