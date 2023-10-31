module "security" {
  source = "./security"
}

module "istio" {
  source = "./istio"
}

module "pihole" {
  source   = "./pihole"
  hostname = var.hostname

  depends_on = [
    module.istio.base,
    module.istio.istiod,
    module.istio.gateway,
  ]
}

module "external-dns" {
  source                = "./external-dns"
  hostname              = var.hostname
  pihole_service_name   = module.pihole.service_name
  pihole_admin_password = module.pihole.admin_password

  depends_on = [
    module.pihole.pi_hole,
  ]
}
