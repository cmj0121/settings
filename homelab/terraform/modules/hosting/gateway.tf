resource "kubernetes_manifest" "hosting-gw" {
  manifest = yamldecode(templatefile("${path.module}/templates/gateway.yml", {
    name      = "${local.namespace}-gw",
    namespace = local.namespace,
    hostname  = var.hostname,
  }))
}

resource "kubernetes_manifest" "gitea-ssh-gw" {
  manifest = yamldecode(templatefile("${path.module}/templates/gitea-ssh-gateway.yml", {
    name      = "gitea-ssh-gw",
    namespace = local.namespace,
  }))
}
