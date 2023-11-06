locals {
  name    = "postgresql"
  version = "13.2.1"

  hostname = "${local.name}.${var.hostname}"
  port     = 5432
}

resource "helm_release" "postgresql" {
  name      = local.name
  chart     = "https://charts.bitnami.com/bitnami/${local.name}-${local.version}.tgz"
  namespace = var.namespace

  values = [templatefile("${path.module}/values.yml", {
    storage_class_name = var.storage_class_name
    password           = random_password.password.result
  })]
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
    service_name = "${local.name}"
    service_port = local.port
  }))
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#"
}
