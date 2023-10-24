locals {
  name    = "gitea"
  version = "9.5.1"

  admin_username = "gitea-admin"
}

resource "helm_release" "gitea" {
  name       = local.name
  repository = "https://dl.gitea.com/charts/"
  chart      = "gitea"
  version    = local.version
  namespace  = var.namespace

  set {
    name  = "persistence.enabled"
    value = false
  }

  set {
    name  = "gitea.admin.username"
    value = local.admin_username
  }

  set {
    name  = "gitea.admin.password"
    value = random_password.password.result
  }

  set {
    name  = "postgresql-ha.enabled"
    value = false
  }

  set {
    name  = "gitea.config.database.DB_TYPE"
    value = "sqlite3"
  }

  set {
    name  = "gitea.config.database.HOST"
    value = "example.com:80"
  }

  set {
    name  = "gitea.additionalConfigSources[0].configMap.name"
    value = kubernetes_config_map.gitea-config-app-ini.metadata.0.name
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
  override_special = "!#$"
}
