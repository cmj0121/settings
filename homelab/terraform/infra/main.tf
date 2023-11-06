module "security" {
  source = "./security"
}

module "istio" {
  source = "./istio"
}

module "nfs-storage" {
  source = "./nfs-storage"
  count  = var.nfs_server != "" ? 1 : 0

  nfs_server = var.nfs_server
  nfs_path   = var.nfs_path
}
