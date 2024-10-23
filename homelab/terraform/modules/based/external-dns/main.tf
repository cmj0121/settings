locals {
  name      = "external-dns"
  namespace = "external-dns"
  version   = var.helm_version
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
  # version    = local.version
  chart     = "https://github.com/kubernetes-sigs/external-dns/releases/download/external-dns-helm-chart-${local.version}/external-dns-${local.version}.tgz"
  namespace = local.namespace

  depends_on = [kubernetes_namespace.external-dns]
  timeout    = 600

  values = [templatefile("${path.module}/values.yml", {
    hostname              = var.hostname,
    pihole_service_name   = var.pihole_service_name,
    pihole_admin_password = var.pihole_admin_password,
  })]
}
