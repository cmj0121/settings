locals {
  namespace = "security"
}

resource "kubernetes_namespace" "security" {
  metadata {
    name = local.namespace
  }
}

module "sealed_secrets" {
  source    = "./sealed_secrets"
  namespace = kubernetes_namespace.security.metadata[0].name
}
