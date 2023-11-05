locals {
  example-ns = "nfs-example"
  enabled    = false
}

resource "kubernetes_namespace" "example-ns" {
  count = local.enabled ? 1 : 0

  metadata {
    name = local.example-ns
  }
}

resource "kubernetes_manifest" "example-pvc" {
  count = local.enabled ? 1 : 0

  manifest = yamldecode(templatefile("${path.module}/values/pvc.yml", {
    namespace    = kubernetes_namespace.example-ns[0].metadata[0].name,
    pvc-claim    = "example-pvc",
    storage-name = "nfs-client",
  }))
}

resource "kubernetes_manifest" "example-job" {
  count = local.enabled ? 1 : 0

  manifest = yamldecode(templatefile("${path.module}/values/job.yml", {
    namespace = kubernetes_namespace.example-ns[0].metadata[0].name,
    pvc-name  = "example-job-pvc",
    pvc-claim = kubernetes_manifest.example-pvc[0].manifest.metadata.name
  }))
}
