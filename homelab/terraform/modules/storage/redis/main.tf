locals {
  name    = "redis"
  version = "18.2.0"

  hostname = "${local.name}.${var.hostname}"
}

resource "helm_release" "redis" {
  name      = local.name
  chart     = "https://charts.bitnami.com/bitnami/${local.name}-${local.version}.tgz"
  namespace = var.namespace

  values = [templatefile("${path.module}/values.yml", {})]
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#"
}
