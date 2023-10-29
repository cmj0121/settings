locals {
  name         = "external-dns"
  helm_version = "1.13.1"
  namespace    = "external-dns"
}

resource "kubernetes_namespace" "external-dns" {
  metadata {
    name = local.namespace
  }
}

resource "helm_release" "external-dns" {
  name = local.name
  # the repository is not working and the chart is not available
  # ============================================================
  # repository = "https://kubernetes-sigs.github.io/external-dns/"
  # chart      = local.name
  # version    = local.helm_version
  chart     = "https://github.com/kubernetes-sigs/external-dns/releases/download/external-dns-helm-chart-1.13.1/external-dns-1.13.1.tgz"
  namespace = local.namespace

  depends_on = [kubernetes_namespace.external-dns]
  values = [templatefile("${path.module}/values.yml", {
    hostname = var.hostname,
  })]
}
