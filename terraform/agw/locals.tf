locals {
  name_prefix                    = "aks-agw"
  blue_backend_address_pool_name  = "${local.name_prefix}-beap-blue"
  green_backend_address_pool_name = "${local.name_prefix}-beap-green"
  frontend_port_name             = "${local.name_prefix}-feport"
  frontend_ip_configuration_name = "${local.name_prefix}-feip"
  http_setting_name              = "${local.name_prefix}-be-htst"
  listener_name                  = "${local.name_prefix}-httplstn"
  request_routing_rule_name      = "${local.name_prefix}-rqrt"
  redirect_configuration_name    = "${local.name_prefix}-rdrcfg"
  deploy_blue_backend_pool       = var.current_active_cluster == "blue" ? true : false
  deploy_green_backend_pool       = var.current_active_cluster == "green" ? true : false
  common_tags = {
    deployed_by = "Terraform"
    repo        = "aks_blue_green"
    name        = var.maintainer
    environment = "Dev"
  }
}
