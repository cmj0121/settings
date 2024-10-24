locals {
  namespace = "hosting"
}

resource "kubernetes_namespace" "hosting" {
  metadata {
    name = local.namespace

    labels = {
      # inject istio sidecar
      istio-injection = "enabled"
    }
  }
}

module "gitea" {
  source    = "./gitea"
  hostname  = var.hostname
  namespace = kubernetes_namespace.hosting.metadata[0].name

  redis_host         = var.redis_host
  redis_port         = var.redis_port
  storage_class_name = var.storage_class_name
}

module "gitea-action-runner" {
  source                  = "./gitea-action-runner"
  namespace               = kubernetes_namespace.hosting.metadata[0].name
  gitea_service           = "http://${module.gitea.servicename}.svc.cluster.local:3000"
  gitea_act_runner_tokens = var.gitea_act_runner_tokens
  storage_class_name      = var.storage_class_name

  depends_on = [
    module.gitea
  ]
}
