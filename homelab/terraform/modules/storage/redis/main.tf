locals {
  name     = "redis"
  version  = var.helm_version
  hostname = "${local.name}.${var.hostname}"
  port     = 6379
}

resource "helm_release" "redis" {
  name      = local.name
  chart     = "https://charts.bitnami.com/bitnami/${local.name}-${local.version}.tgz"
  namespace = var.namespace

  values = [templatefile("${path.module}/values.yml", {})]
}

resource "kubernetes_manifest" "gateway" {
  manifest = yamldecode(templatefile("${path.module}/../templates/gateway.yml", {
    name      = "${local.name}-gw"
    namespace = var.namespace

    service_port = local.port
  }))
}

resource "kubernetes_manifest" "virtual-service" {
  manifest = yamldecode(templatefile("${path.module}/../templates/virtual_service.yml", {
    name      = "${local.name}-vs"
    namespace = var.namespace


    gateway      = kubernetes_manifest.gateway.manifest.metadata.name
    service_name = "${local.name}-master"
    service_port = local.port
  }))
}
