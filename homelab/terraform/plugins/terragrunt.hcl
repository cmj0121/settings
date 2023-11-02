include "parent" {
  path   = find_in_parent_folders()
  expose = true
}


terraform {
  source = "main.tf"
}
