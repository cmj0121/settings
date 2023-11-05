resource "kubernetes_manifest" "redis-vs" {
  manifest = yamldecode(templatefile("${path.module}/templates/virtual_service.yml", {
    name      = "redis-vs"
    namespace = local.namespace

    port     = 6379
    hostname = module.redis.hostname

    gateway      = kubernetes_manifest.storage-gw.manifest.metadata.name
    service_name = module.redis.service_name
  }))
}

resource "kubernetes_manifest" "postgresql-vs" {
  manifest = yamldecode(templatefile("${path.module}/templates/virtual_service.yml", {
    name      = "postgresql-vs"
    namespace = local.namespace

    port     = 5432
    hostname = module.postgresql.hostname

    gateway      = kubernetes_manifest.storage-gw.manifest.metadata.name
    service_name = module.postgresql.service_name
  }))
}

resource "kubernetes_manifest" "mariadb-vs" {
  manifest = yamldecode(templatefile("${path.module}/templates/virtual_service.yml", {
    name      = "mariadb-vs"
    namespace = local.namespace

    port     = 3306
    hostname = module.mariadb.hostname

    gateway      = kubernetes_manifest.storage-gw.manifest.metadata.name
    service_name = module.mariadb.service_name
  }))
}
