locals {
  name     = "drone"
  hostname = "${local.name}.${var.namespace}.${var.hostname}"

  drone_ver       = "0.6.5"
  runner_ver      = "0.1.10"
  kube_secret_ver = "0.1.4"
}

resource "helm_release" "drone" {
  name      = "drone"
  chart     = "https://charts.drone.io/drone-${local.drone_ver}.tgz"
  namespace = var.namespace

  values = [templatefile("${path.module}/values/drone.yml", {
    hostname   = local.hostname,
    rpc_secret = random_password.rpc_secret.result,

    gitea_client_id     = gitea_oauth2_app.drone-oauth-app.client_id,
    gitea_client_secret = gitea_oauth2_app.drone-oauth-app.client_secret,
    gitea_server        = "http://${var.gitea_hostname}",
  })]
}

resource "helm_release" "drone-runner-kube" {
  name      = "drone-runner-kube"
  chart     = "https://charts.drone.io/drone-runner-kube-${local.runner_ver}.tgz"
  namespace = var.namespace

  values = [templatefile("${path.module}/values/drone-runner-kube.yml", {
    rpc_secret   = random_password.rpc_secret.result,
    namespace    = var.namespace,
    plugin_token = random_password.plugin_token.result,
  })]
}

resource "helm_release" "drone-secret" {
  name      = "drone-secret"
  chart     = "https://charts.drone.io/drone-kubernetes-secrets-${local.kube_secret_ver}.tgz"
  namespace = var.namespace

  values = [templatefile("${path.module}/values/drone-kubernetes-secrets.yml", {
    rpc_secret   = random_password.rpc_secret.result,
    namespace    = var.namespace,
    plugin_token = random_password.plugin_token.result,
  })]
}

resource "random_password" "rpc_secret" {
  length           = 16
  special          = true
  override_special = "!#$"
}

resource "random_password" "plugin_token" {
  length           = 16
  special          = true
  override_special = "!#$"
}
