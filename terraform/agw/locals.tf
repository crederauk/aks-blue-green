locals {
  name_prefix                    = "aks-agw"
  backend_address_pool_name      = "${local.name_prefix}-beap"
  frontend_port_name             = "${local.name_prefix}-feport"
  frontend_ip_configuration_name = "${local.name_prefix}-feip"
  http_setting_name              = "${local.name_prefix}-be-htst"
  listener_name                  = "${local.name_prefix}-httplstn"
  request_routing_rule_name      = "${local.name_prefix}-rqrt"
  redirect_configuration_name    = "${local.name_prefix}-rdrcfg"
  common_tags = {
    deployed_by = "Terraform"
    repo        = "aks_blue_green"
  }
}
