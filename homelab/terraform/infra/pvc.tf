// The PVC (Persistent Volume Claim) resource is used to request storage from a Persistent Volume (PV).

locals {
  config  = jsondecode(data.kubernetes_config_map.local-storage-config.data["config.json"])
  pathmap = { for item in local.config["nodePathMap"] : item.node => item.paths }
}

data "kubernetes_config_map" "local-storage-config" {
  metadata {
    name      = "local-path-config"
    namespace = "kube-system"
  }
}

resource "null_resource" "check_local_path" {
  count = contains(local.pathmap["DEFAULT_PATH_FOR_NON_LISTED_NODES"], var.local_storage_path) ? 0 : 1

  provisioner "local-exec" {
    command = "echo 'The path ${var.local_storage_path} is not in cm/local-path-config' && exit 1"
  }
}

resource "kubernetes_storage_class" "local-storageclass" {
  depends_on = [null_resource.check_local_path]

  metadata {
    name = var.storage_class_name
  }

  storage_provisioner    = "rancher.io/local-path"
  reclaim_policy         = "Delete"
  volume_binding_mode    = "WaitForFirstConsumer"
  allow_volume_expansion = true

  parameters = {
    nodePath    = var.local_storage_path
    pathPattern = "{{ .PVC.Namespace }}/{{ .PVC.Name }}"
  }
}
