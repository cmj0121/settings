resource "kubernetes_manifest" "storage-gw" {
  manifest = yamldecode(templatefile("${path.module}/templates/gateway.yml", {
    name      = "storage-gw"
    namespace = local.namespace
  }))
}
