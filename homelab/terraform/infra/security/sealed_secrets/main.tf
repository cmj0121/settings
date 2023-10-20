locals {
  name    = "sealed-secrets"
  version = "2.13.0"
}

resource "helm_release" "sealed-secrets" {
  name       = local.name
  repository = "https://bitnami-labs.github.io/sealed-secrets"
  chart      = "sealed-secrets"
  version    = local.version
  namespace  = var.namespace
}
