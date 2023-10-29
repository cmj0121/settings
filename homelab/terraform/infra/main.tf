module "security" {
  source = "./security"
}

module "istio" {
  source = "./istio"
}

module "pihole" {
  source   = "./pihole"
  hostname = var.hostname
}

module "external-dns" {
  source   = "./external-dns"
  hostname = var.hostname
}
