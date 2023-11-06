locals {
  name    = "postgresql"
  version = "13.2.1"

  hostname = "${local.name}.${var.hostname}"
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

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#"
}