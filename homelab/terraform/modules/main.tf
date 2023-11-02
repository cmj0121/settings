module "networking" {
  source   = "./networking"
  hostname = var.hostname
}

module "monitoring" {
  source   = "./monitoring"
  hostname = var.hostname

  depends_on = [
    module.networking,
  ]
}
