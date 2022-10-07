locals {
  name_prefix = "aks"
  cluster     = "blue"
  common_tags = {
    deployed_by = "Terraform"
    repo        = "aks_blue_green"
    name        = var.maintainer
    environment = "Dev"
  }
  ingress_ip = cidrhost(data.terraform_remote_state.base_infra.outputs.sn.blue.cidr, 200)
}
