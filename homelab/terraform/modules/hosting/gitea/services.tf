resource "kubernetes_manifest" "service-entry" {
  manifest = yamldecode(templatefile("${path.module}/../templates/service-entry.yml", {
    name      = local.name
    namespace = var.namespace

    hostname     = local.hostname
    service_name = "${local.name}-http"
    service_port = "3000"
  }))
}
