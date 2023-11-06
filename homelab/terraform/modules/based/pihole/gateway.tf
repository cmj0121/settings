resource "kubernetes_manifest" "pihole-web-gw" {
  manifest = yamldecode(templatefile("${path.module}/templates/gateway.yml", {
    name      = "${local.namespace}-web-gw"
    namespace = local.namespace
    hostname  = "*.${var.hostname}"

    service_name     = "http"
    service_port     = "80"
    service_protocal = "HTTP"
  }))
}
