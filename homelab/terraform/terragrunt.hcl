locals {
  config_context = "homelab"
  config_path    = "~/.kube/config"

  suffix = "${path_relative_to_include() == "." ? "default" : path_relative_to_include()}"
}


remote_state {
  backend = "kubernetes"
  config = {
    secret_suffix  = "state-${local.suffix}"
    config_path    = local.config_path
    config_context = local.config_context
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
}
