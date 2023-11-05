resource "kubernetes_manifest" "redis-vs" {
  manifest = yamldecode(templatefile("${path.module}/templates/virtual_service.yml", {
    name      = "redis-vs"
    namespace = local.namespace
    hostname  = module.redis.hostname

    gateway      = kubernetes_manifest.storage-gw.manifest.metadata.name
    service_name = module.redis.service_name
  }))
}
