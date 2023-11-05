resource "kubernetes_manifest" "monitoring-gw" {
  manifest = yamldecode(templatefile("${path.module}/templates/gateway.yml", {
    name      = "monitoring-gw"
    namespace = local.namespace
    hostname  = var.hostname
  }))
}
