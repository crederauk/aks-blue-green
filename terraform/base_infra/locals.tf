locals {
  name_prefix   = "aks"
  blue_sn_cidr  = cidrsubnet(var.address_space, 4, 0)
  green_sn_cidr = cidrsubnet(var.address_space, 4, 1)
  agw_sn_cidr   = cidrsubnet(var.address_space, 4, 2)
  common_tags = {
    deployed_by = "Terraform"
    repo        = "aks_blue_green"
    name        = var.maintainer
    environment = "Dev"
  }
}
