locals {
  name_prefix                    = "aks-agw"
  backend_address_pool_name      = "${local.name_prefix}-beap-blue"
  frontend_port_name             = "${local.name_prefix}-feport"
  frontend_ip_configuration_name = "${local.name_prefix}-feip"
  http_setting_name              = "${local.name_prefix}-be-htst"
  listener_name                  = "${local.name_prefix}-httplstn"
  request_routing_rule_name      = "${local.name_prefix}-rqrt"
  redirect_configuration_name    = "${local.name_prefix}-rdrcfg"
  route_to_blue_backend_pool     = var.current_active_cluster == "blue" ? true : false
  route_to_green_backend_pool    = var.current_active_cluster == "green" ? true : false
  backend_address_pool_ips       = flatten([local.route_to_blue_backend_pool ? [lookup(data.terraform_remote_state.aks_blue.outputs, "internal_ip", null)] : []])
  # local.route_to_green_backend_pool ? [lookup(data.terraform_remote_state.aks_green.outputs, "internal_ip", null)] : []
  common_tags = {
    deployed_by = "Terraform"
    repo        = "aks_blue_green"
    name        = var.maintainer
    environment = "Dev"
  }
}
