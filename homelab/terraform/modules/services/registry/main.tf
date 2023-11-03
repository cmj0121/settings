locals {
  name      = "registry"
  image     = "registry"
  image_tag = "2.8.3"
  port      = 80
  hostname  = "${local.name}.${var.namespace}.${var.hostname}"
}

resource "kubernetes_manifest" "registry" {
  manifest = yamldecode(templatefile("${path.module}/values/deployment.yml", {
    name      = local.name,
    namespace = var.namespace,

    image     = local.image,
    image_tag = local.image_tag,
    port      = local.port,
  }))
}

resource "kubernetes_manifest" "registry-svc" {
  manifest = yamldecode(templatefile("${path.module}/values/service.yml", {
    name      = local.name,
    namespace = var.namespace,
    port      = local.port,
  }))
}

resource "kubernetes_manifest" "registry-vs" {
  manifest = yamldecode(templatefile("${path.module}/values/virtual_service.yml", {
    name      = local.name,
    namespace = var.namespace,
    port      = local.port,
    hostname  = local.hostname,
  }))
}
