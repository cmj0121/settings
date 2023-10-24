module "monitoring" {
  source   = "./monitoring"
  hostname = var.hostname
}

module "hosting" {
  source   = "./hosting"
  hostname = var.hostname
}
