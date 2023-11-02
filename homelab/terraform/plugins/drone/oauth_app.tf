terraform {
  required_providers {
    gitea = {
      source  = "go-gitea/gitea"
      version = "0.3.0"
    }
  }
}

resource "gitea_oauth2_app" "drone-oauth-app" {
  name                = "drone-oauth-app"
  confidential_client = true
  redirect_uris = [
    "http://${local.hostname}/login",
  ]
}
