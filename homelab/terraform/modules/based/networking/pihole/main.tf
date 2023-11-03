locals {
  name         = "pihole"
  helm_version = "2.18.0"
  namespace    = "pihole"
}

resource "kubernetes_namespace" "pihole" {
  metadata {
    name = local.namespace
  }
}

resource "helm_release" "pihole" {
  name = local.name
  # the repository is not working and the chart is not available
  # ============================================================
  # repository = "https://mojo2600.github.io/pihole-kubernetes/"
  # chart      = local.name
  # version    = local.helm_version
  chart     = "https://github.com/MoJo2600/pihole-kubernetes/releases/download/pihole-2.18.0/pihole-2.18.0.tgz"
  namespace = local.namespace

  values = [templatefile("${path.module}/values.yml", {
    hostname = var.hostname,
    password = random_password.password.result,
  })]
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$"
}
