include "parent" {
  path   = find_in_parent_folders()
  expose = true
}

remote_state = include.parent.remote_state


terraform {
  source = "main.tf"
}
