resource "kubernetes_manifest" "gitea-ssh-gw" {
  manifest = {
    apiVersion = "networking.istio.io/v1beta1"
    kind       = "Gateway"

    metadata = {
      name      = "${local.name}-ssh-gw"
      namespace = var.namespace

      labels = {
        app     = var.namespace
        service = "ssh"
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
            number   = 2222
            name     = "ssh"
            protocol = "TCP"
          }

          hosts = ["*"]
        }
      ]
    }
  }
}

resource "kubernetes_manifest" "gitea-ssh-vs" {
  manifest = {
    apiVersion = "networking.istio.io/v1beta1"
    kind       = "VirtualService"

    metadata = {
      name      = "${local.name}-ssh-vs"
      namespace = var.namespace

      labels = {
        app     = "${local.name}"
        service = "ssh"
      }
    }

    spec = {
      # The destination hosts to which traffic is being sent.
      hosts = ["*"]

      # The names of gateways and sidecars that should apply these routes.
      gateways = ["${local.name}-ssh-gw"]

      tcp = [
        {
          match = [
            {
              port : 2222
            }
          ]

          route = [
            {
              destination = {
                host = "${local.name}-ssh"
                port = {
                  number = 2222
                }
              }
            }
          ]
        }
      ]
    }
  }
}
