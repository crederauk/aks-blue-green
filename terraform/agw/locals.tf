locals {
  name_prefix                     = "aks-agw"
  blue_backend_address_pool_name  = "${local.name_prefix}-beap-blue"
  green_backend_address_pool_name = "${local.name_prefix}-beap-green"
  frontend_port_name              = "${local.name_prefix}-feport"
  frontend_ip_configuration_name  = "${local.name_prefix}-feip"
  blue_http_setting_name          = "${local.name_prefix}-be-htst-blue"
  green_http_setting_name         = "${local.name_prefix}-be-htst-green"
  listener_name                   = "${local.name_prefix}-httplstn"
  request_routing_rule_name       = "${local.name_prefix}-rqrt"
  redirect_configuration_name     = "${local.name_prefix}-rdrcfg"
  route_to_blue_backend_pool      = var.current_active_cluster == "blue" ? true : false
  route_to_green_backend_pool     = var.current_active_cluster == "green" ? true : false
  blue_backend_address_pool_ips   = lookup(data.terraform_remote_state.aks_blue.outputs, "internal_ip", "not_found")
  green_backend_address_pool_ips  = lookup(data.terraform_remote_state.aks_green.outputs, "internal_ip", "not_found")
  current_backend_address_pool    = var.current_active_cluster == "blue" ? local.blue_backend_address_pool_name : local.green_backend_address_pool_name
  current_http_setting            = var.current_active_cluster == "blue" ? local.blue_http_setting_name : local.green_http_setting_name
  common_tags = {
    deployed_by = "Terraform"
    repo        = "aks_blue_green"
    name        = var.maintainer
    environment = "Dev"
  }
}
