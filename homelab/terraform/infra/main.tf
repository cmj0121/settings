module "security" {
  source = "./security"
}

module "istio" {
  source = "./istio"
}

module "external-dns" {
  source   = "./external-dns"
  hostname = var.hostname
}
