resource "kubernetes_manifest" "external-dns-gw" {
  manifest = {
    apiVersion = "networking.istio.io/v1beta1"
    kind       = "Gateway"

    metadata = {
      name      = "${local.name}-gw"
      namespace = local.namespace

      labels = {
        app     = local.namespace
        service = "dns"
      }
    }

    spec = {
      selector = {
        # Select the default istio gateway service.
        istio = "gateway"
      }

      servers = [
        {
          port = {
            number   = 53
            name     = "dns"
            protocol = "TCP"
          }

          hosts = ["*"]
        }
      ]
    }
  }
}
