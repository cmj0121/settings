resource "kubernetes_manifest" "pihole-web-vs" {
  manifest = {
    apiVersion = "networking.istio.io/v1beta1"
    kind       = "VirtualService"

    metadata = {
      name      = "${local.name}-web-vs"
      namespace = local.namespace

      labels = {
        app     = "${local.name}-web"
        service = "http"
      }
    }

    spec = {
      # The destination hosts to which traffic is being sent.
      hosts = ["${local.name}.${var.hostname}"]

      # The names of gateways and sidecars that should apply these routes.
      gateways = ["${kubernetes_manifest.pihole-web-gw.manifest.metadata.name}"]

      # A HTTP rule can either return a direct_response, redirect or forward
      # (default) traffic.
      http = [
        {
          route = [
            {
              destination = {
                # Destination indicates the network addressable service to which the
                # request/connection will be sent after processing a routing rule.
                host = "${local.name}-web"
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

resource "kubernetes_manifest" "pihole-dns-vs" {
  manifest = {
    apiVersion = "networking.istio.io/v1beta1"
    kind       = "VirtualService"

    metadata = {
      name      = "${local.name}-dns-vs"
      namespace = local.namespace

      labels = {
        app     = "${local.name}-dns"
        service = "dns"
      }
    }

    spec = {
      # The destination hosts to which traffic is being sent.
      hosts = ["*"]

      # The names of gateways and sidecars that should apply these routes.
      gateways = ["${kubernetes_manifest.pihole-dns-gw.manifest.metadata.name}"]

      tcp = [
        {
          match = [
            {
              port : 53
            }
          ]

          route = [
            {
              destination = {
                host = "${local.name}-dns-tcp"
                port = {
                  number = 53
                }
              }
            }
          ]
        }
      ]
    }
  }
}
