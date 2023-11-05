locals {
  name    = "loki"
  version = "2.11.12"
}

resource "helm_release" "loki" {
  name       = local.name
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "grafana-loki"
  version    = local.version
  namespace  = var.namespace

  values = [templatefile("${path.module}/values.yml", {
    storage_class_name = var.storage_class_name,
  })]
}
