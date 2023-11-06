locals {
  name    = "grafana"
  version = "9.5.0"

  admin_username = "grafana-admin"
  hostname       = "${local.name}.${var.hostname}"
}

resource "helm_release" "grafana" {
  name      = local.name
  chart     = "https://charts.bitnami.com/bitnami/grafana-${local.version}.tgz"
  namespace = var.namespace

  values = [templatefile("${path.module}/values.yml", {
    hostname           = var.hostname,
    username           = local.admin_username,
    password           = random_password.password.result,
    storage_class_name = var.storage_class_name,
  })]
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&-_=+:?"
}
