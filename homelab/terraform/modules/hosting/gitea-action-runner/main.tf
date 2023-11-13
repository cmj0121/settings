locals {
  tokens = [for idx in range(length(var.gitea_act_runner_tokens)) : tostring(idx)]
  image  = "gitea/act_runner:nightly-dind-rootless"
}

resource "kubernetes_manifest" "pvc" {
  for_each = toset(local.tokens)

  manifest = yamldecode(templatefile("${path.module}/values/pvc.yml", {
    name      = "gitea-action-runner-${each.key}",
    namespace = var.namespace,
  }))
}

resource "kubernetes_manifest" "secret" {
  for_each = toset(local.tokens)

  manifest = yamldecode(templatefile("${path.module}/values/secret.yml", {
    name      = "gitea-action-runner-${each.key}",
    namespace = var.namespace,

    secret = base64encode(var.gitea_act_runner_tokens[each.key]),
  }))
}

resource "kubernetes_manifest" "deployment" {
  for_each = toset(local.tokens)

  manifest = yamldecode(templatefile("${path.module}/values/deployment.yml", {
    name      = "gitea-action-runner-${each.key}",
    namespace = var.namespace,

    uid   = 1000,
    image = local.image,

    gitea_service = var.gitea_service,
    secret_name   = kubernetes_manifest.secret[each.key].manifest.metadata.name,
    pvc_claim     = kubernetes_manifest.pvc[each.key].manifest.metadata.name,
  }))
}
