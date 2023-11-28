locals {
  name     = "gitea"
  version  = "9.6.1"
  hostname = "${local.name}.${var.hostname}"

  admin_username = "gitea-admin"
}

resource "helm_release" "gitea" {
  name      = local.name
  chart     = "https://dl.gitea.com/charts/${local.name}-${local.version}.tgz"
  namespace = var.namespace

  values = [templatefile("${path.module}/values.yml", {
    storage_class_name = var.storage_class_name,
  })]

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
      ROOT_URL   = http://${local.hostname}
      DOMAIN     = ${local.hostname}
      SSH_DOMAIN = ${local.hostname}
    EOF

    actions = <<EOF
      ENABLED = true
    EOF
  }
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#"
}
