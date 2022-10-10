resource "azurerm_application_gateway" "network" {
  name                = "${local.name_prefix}-agw"
  resource_group_name = data.terraform_remote_state.base_infra.outputs.aks_rg.name
  location            = data.terraform_remote_state.base_infra.outputs.aks_rg.location

  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "${local.name_prefix}-agw-ip-config"
    subnet_id = data.terraform_remote_state.base_infra.outputs.sn.agw.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = data.terraform_remote_state.base_infra.outputs.agw_pip_id
  }

  backend_address_pool {
    name         = local.backend_address_pool_name
    ip_addresses = local.backend_address_pool_ips
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }

  tags = local.common_tags
}

