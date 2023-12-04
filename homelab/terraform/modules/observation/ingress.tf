resource "kubernetes_manifest" "grafana-vs" {
  manifest = yamldecode(templatefile("${path.module}/templates/virtual_service.yml", {
    name      = "grafana-vs"
    namespace = local.namespace
    hostname  = module.grafana.hostname

    gateway      = kubernetes_manifest.monitoring-gw.manifest.metadata.name
    service_name = "grafana"
  }))
}
