locals {
  example-ns = "pvc-test"
  name       = "example-pvc"
  enabled    = false
}

resource "kubernetes_namespace" "vpc-test" {
  count = local.enabled ? 1 : 0

  metadata {
    name = local.example-ns
  }
}

resource "kubernetes_manifest" "example-pvc" {
  count = local.enabled ? 1 : 0

  manifest = yamldecode(templatefile("${path.module}/values/pvc.yml", {
    namespace    = kubernetes_namespace.vpc-test[0].metadata[0].name,
    storage-name = var.storage_class_name,
    pvc-name     = local.name
  }))
}

resource "kubernetes_manifest" "example-job" {
  count = local.enabled ? 1 : 0

  manifest = yamldecode(templatefile("values/job.yml", {
    namespace = kubernetes_namespace.vpc-test[0].metadata[0].name,
    pvc-name  = local.name
  }))
}
