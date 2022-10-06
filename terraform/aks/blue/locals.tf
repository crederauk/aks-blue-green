locals {
  name_prefix = "aks"
  cluster     = "blue"
  common_tags = {
    deployed_by = "Terraform"
    repo        = "aks_blue_green"
  }
}
