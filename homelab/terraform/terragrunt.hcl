locals {
  config_context = "homelab"
  config_path    = "~/.kube/config"

  suffix = "${path_relative_to_include() == "." ? "default" : path_relative_to_include()}"
}

inputs = {
  hostname = "home.lab"
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

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"

  contents = <<EOT
provider "kubernetes" {
  config_path    = "${local.config_path}"
  config_context = "${local.config_context}"
}

provider "helm" {
  kubernetes {
    config_path = "${local.config_path}"
  }
}
EOT
}
