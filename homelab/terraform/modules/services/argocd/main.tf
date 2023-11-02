locals {
  name    = "argocd"
  version = "5.47.0"
}

resource "helm_release" "argocd" {
  name       = local.name
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = local.version
  namespace  = var.namespace

  values = [
    templatefile("${path.module}/values.yml", {
      admin_password = null_resource.encrypt_password.triggers.password
    })
  ]
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#"
}

resource "null_resource" "encrypt_password" {
  triggers = {
    password = bcrypt(random_password.password.result, 10)
  }

  lifecycle {
    ignore_changes = [triggers]
  }
}
