locals {
  config_context = "homelab"
  config_path    = "~/.kube/config"
}


remote_state {
  backend = "kubernetes"
  config = {
    secret_suffix = "state"

    config_path    = local.config_path
    config_context = local.config_context
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
}

terraform {
  source = "main.tf"
}
