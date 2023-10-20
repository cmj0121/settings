locals {
  enabled_demo_app = false
  sample_image     = "nginx:1.14.2"
}

resource "kubernetes_namespace" "demo-app" {
  count = local.enabled_demo_app ? 1 : 0

  metadata {
    name = "demo-app"

    labels = {
      # New pods that are created in that namespace will automatically have a
      # sidecar added to them.
      istio-injection = "enabled"
    }
  }
}

resource "kubernetes_deployment" "demo-app" {
  count = local.enabled_demo_app ? 1 : 0

  metadata {
    name      = "demo-app"
    namespace = kubernetes_namespace.demo-app[0].metadata[0].name

    labels = {
      app = "demo"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "demo"
      }
    }

    template {
      metadata {
        labels = {
          app = "demo"
        }
      }

      spec {
        container {
          name  = "demo-app"
          image = local.sample_image
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "demo-svc" {
  count = local.enabled_demo_app ? 1 : 0

  metadata {
    name      = "demo-svc"
    namespace = kubernetes_namespace.demo-app[0].metadata[0].name

    labels = {
      app = "demo"
    }
  }

  spec {
    selector = {
      app = "demo"
    }

    port {
      port        = 80
      target_port = 80
    }
  }
}

resource "kubernetes_manifest" "demo-gw" {
  count = local.enabled_demo_app ? 1 : 0

  manifest = {
    apiVersion = "networking.istio.io/v1alpha3"
    kind       = "Gateway"

    metadata = {
      name      = "demo-gw"
      namespace = kubernetes_namespace.demo-app[0].metadata[0].name

      labels = {
        app = "demo"
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

          hosts = ["*"]
        }
      ]
    }
  }
}

resource "kubernetes_manifest" "demo-vs" {
  count = local.enabled_demo_app ? 1 : 0

  manifest = {
    apiVersion = "networking.istio.io/v1alpha3"
    kind       = "VirtualService"

    metadata = {
      name      = "demo-vs"
      namespace = kubernetes_namespace.demo-app[0].metadata[0].name

      labels = {
        app = "demo"
      }
    }

    spec = {
      # The destination hosts to which traffic is being sent.
      hosts = ["*"]

      # The names of gateways and sidecars that should apply these routes.
      gateways = ["demo-gw"]

      # A HTTP rule can either return a direct_response, redirect or forward
      # (default) traffic.
      http = [
        {
          route = [
            {
              destination = {
                # Destination indicates the network addressable service to which the
                # request/connection will be sent after processing a routing rule.
                host = "demo-svc"
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
