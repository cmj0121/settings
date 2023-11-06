resource "kubernetes_manifest" "pihole-web-vs" {
  manifest = yamldecode(templatefile("${path.module}/templates/virtual-service.yml", {
    name      = "${local.namespace}-web-vs"
    namespace = local.namespace
    hostname  = local.hostname
    gateway   = kubernetes_manifest.pihole-web-gw.manifest.metadata.name

    service_name = "pihole-web"
    service_port = "80"
  }))
}
