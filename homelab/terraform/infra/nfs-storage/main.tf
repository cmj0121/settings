locals {
  name    = "nfs-storage"
  version = "4.0.18"

  namespace = "nfs-storage"
}

resource "kubernetes_namespace" "storage" {
  metadata {
    name = local.namespace
  }
}

resource "helm_release" "nfs-storage" {
  name       = local.name
  repository = "https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/"
  chart      = "nfs-subdir-external-provisioner"
  version    = local.version
  namespace  = kubernetes_namespace.storage.metadata[0].name

  set {
    name  = "nfs.server"
    value = var.nfs_server
  }

  set {
    name  = "nfs.path"
    value = var.nfs_path
  }
}
