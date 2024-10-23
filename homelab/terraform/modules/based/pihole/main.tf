locals {
  name         = "pihole"
  namespace    = "pihole"
  helm_version = var.helm_version

  hostname = "${local.name}.${var.hostname}"
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
  chart     = "https://github.com/MoJo2600/pihole-kubernetes/releases/download/pihole-${var.helm_version}/pihole-${var.helm_version}.tgz"
  namespace = local.namespace

  values = [templatefile("${path.module}/values.yml", {
    hostname = var.hostname,
    password = random_password.password.result,

    storage_class_name = var.storage_class_name,
  })]
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$"
}
