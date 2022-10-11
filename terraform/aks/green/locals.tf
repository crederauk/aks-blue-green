locals {
  name_prefix   = "aks"
  cluster       = "green"
  templates_dir = "${path.module}/../aks-templates"
  common_tags = {
    deployed_by = "Terraform"
    repo        = "aks_green_green"
    name        = var.maintainer
    environment = "Dev"
  }
  ingress_ip = cidrhost(data.terraform_remote_state.base_infra.outputs.sn.green.cidr, 200)
}
