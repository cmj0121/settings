resource "kubernetes_manifest" "argocd-vs" {
  manifest = {
    apiVersion = "networking.istio.io/v1beta1"
    kind       = "VirtualService"

    metadata = {
      name      = "${local.name}-vs"
      namespace = var.namespace

      labels = {
        app     = "${local.name}"
        service = "http"
      }
    }

    spec = {
      # The destination hosts to which traffic is being sent.
      hosts = ["${local.name}.${var.namespace}.${var.hostname}"]

      # The names of gateways and sidecars that should apply these routes.
      gateways = ["${var.namespace}-gw"]

      # A HTTP rule can either return a direct_response, redirect or forward
      # (default) traffic.
      http = [
        {
          route = [
            {
              destination = {
                # Destination indicates the network addressable service to which the
                # request/connection will be sent after processing a routing rule.
                host = "${local.name}-server"
                port = {
                  number = 80
                }
              }
            }
          ]
        }
      ]
    }
  }
}
