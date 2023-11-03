locals {
  name    = "gitea"
  version = "9.5.1"

  admin_username = "gitea-admin"
}

resource "helm_release" "gitea" {
  name      = local.name
  chart     = "https://dl.gitea.com/charts/${local.name}-${local.version}.tgz"
  namespace = var.namespace

  values = ["${file("${path.module}/values.yml")}"]

  set {
    name  = "gitea.admin.username"
    value = local.admin_username
  }

  set {
    name  = "gitea.admin.password"
    value = random_password.password.result
  }
}

resource "kubernetes_config_map" "gitea-config-app-ini" {
  metadata {
    name      = "gitea-config-app-ini"
    namespace = var.namespace
  }

  data = {
    server = <<EOF
      ROOT_URL   = http://${local.name}.${var.namespace}.${var.hostname}
      DOMAIN     = ${local.name}.${var.namespace}.${var.hostname}
      SSH_DOMAIN = ${local.name}.${var.namespace}.${var.hostname}
    EOF
  }
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#"
}
