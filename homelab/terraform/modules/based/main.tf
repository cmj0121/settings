module "pihole" {
  source   = "./pihole"
  hostname = var.hostname

  helm_version       = var.pihole_version
  storage_class_name = var.storage_class_name
}

module "external-dns" {
  source   = "./external-dns"
  hostname = var.hostname

  helm_version          = var.external_dns_version
  pihole_service_name   = module.pihole.service_name
  pihole_admin_password = module.pihole.admin_password

  depends_on = [
    module.pihole.pi_hole,
  ]
}
