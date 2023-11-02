resource "kubernetes_manifest" "pihole-web-gw" {
  manifest = {
    apiVersion = "networking.istio.io/v1beta1"
    kind       = "Gateway"

    metadata = {
      name      = "${local.namespace}-web-gw"
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

          hosts = ["*.${var.hostname}"]
        }
      ]
    }
  }
}

resource "kubernetes_manifest" "pihole-dns-gw" {
  manifest = {
    apiVersion = "networking.istio.io/v1beta1"
    kind       = "Gateway"

    metadata = {
      name      = "${local.namespace}-dns-gw"
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
