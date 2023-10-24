resource "kubernetes_manifest" "hosting-gw" {
  manifest = {
    apiVersion = "networking.istio.io/v1alpha3"
    kind       = "Gateway"

    metadata = {
      name      = "${local.namespace}-gw"
      namespace = local.namespace

      labels = {
        app     = local.namespace
        service = "http"
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
            number   = 80
            name     = "http"
            protocol = "HTTP"
          }

          hosts = ["*.${local.namespace}.${var.hostname}"]
        }
      ]
    }
  }
}
