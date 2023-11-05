resource "kubernetes_manifest" "redis-vs" {
  manifest = yamldecode(templatefile("${path.module}/templates/redis-ingress.yml", {
    name      = "redis-vs"
    namespace = local.namespace

    gateway      = kubernetes_manifest.storage-gw.manifest.metadata.name
    service_name = module.redis.service_name
  }))
}
