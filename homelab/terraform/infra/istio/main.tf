locals {
  helm_version = "1.19.3"
  namespace    = "istio-system"
}

resource "kubernetes_namespace" "istio-system" {
  metadata {
    name = local.namespace
  }
}

resource "helm_release" "base" {
  name       = "base"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "base"
  version    = local.helm_version
  namespace  = local.namespace

  depends_on = [kubernetes_namespace.istio-system]
}

resource "helm_release" "istiod" {
  name       = "istiod"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "istiod"
  version    = local.helm_version
  namespace  = local.namespace

  depends_on = [kubernetes_namespace.istio-system]

  values = ["${file("${path.module}/templates/istiod.yml")}"]
}

resource "helm_release" "gateway" {
  name       = "gateway"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "gateway"
  version    = local.helm_version
  namespace  = local.namespace

  depends_on = [kubernetes_namespace.istio-system]

  values = ["${file("istio/gateway_values.yml")}"]
}

resource "null_resource" "dns-proxy" {
  provisioner "local-exec" {
    command = "istioctl install -y -f ${path.module}/templates/dns-proxy.yml"
  }

  depends_on = [
    helm_release.base,
    helm_release.istiod,
    helm_release.gateway,
  ]
}
