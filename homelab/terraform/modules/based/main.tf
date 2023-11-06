module "pihole" {
  source   = "./pihole"
  hostname = var.hostname

  storage_class_name = var.storage_class_name
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
