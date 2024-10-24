resource "kubernetes_manifest" "gitea-vs" {
  manifest = yamldecode(templatefile("${path.module}/templates/virtual_service.yml", {
    name      = "gitea-vs"
    namespace = local.namespace
    hostname  = module.gitea.hostname

    gateway      = kubernetes_manifest.hosting-gw.manifest.metadata.name
    port         = 3000
    service_name = "gitea-http"
  }))
}

resource "kubernetes_manifest" "gitea-ssh-vs" {
  manifest = yamldecode(templatefile("${path.module}/templates/gitea-ssh-vs.yml", {
    name      = "gitea-ssh-vs"
    namespace = local.namespace
    hostname  = module.gitea.hostname

    gateway      = kubernetes_manifest.gitea-ssh-gw.manifest.metadata.name
    service_name = "gitea-ssh"
    service_port = 2222
  }))
}
