locals {
  name    = "grafana"
  version = "6.60.4"

  admin_username = "grafana-admin"
}

resource "helm_release" "grafana" {
  name       = local.name
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  version    = local.version
  namespace  = var.namespace

  set {
    name  = "ingress.enabled"
    value = true
  }

  set {
    name  = "ingress.hosts[0]"
    value = "${local.name}.${var.hostname}"
  }

  set {
    name  = "adminUser"
    value = local.admin_username
  }

  set {
    name  = "adminPassword"
    value = random_password.password.result
  }
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&-_=+:?"
}
