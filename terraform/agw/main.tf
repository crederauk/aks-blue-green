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

  probe {
    name                                      = "nginx-ingress-probe"
    pick_host_name_from_backend_http_settings = true
    path                                      = "/healthz"
    protocol                                  = "Http"
    interval                                  = 30
    timeout                                   = 30
    unhealthy_threshold                       = 3
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
    backend_address_pool_name  = local.current_backend_address_pool
    backend_http_settings_name = local.current_http_setting
  }

  ### Blue Cluster Backend ###
  backend_address_pool {
    name         = local.blue_backend_address_pool_name
    ip_addresses = local.blue_backend_address_pool_ips
  }

  backend_http_settings {
    name                                = local.blue_http_setting_name
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 80
    protocol                            = "Http"
    request_timeout                     = 60
    pick_host_name_from_backend_address = true
    probe_name                          = "nginx-ingress-probe"
  }

  ### Green Cluster Backend ###
  backend_address_pool {
    name         = local.green_backend_address_pool_name
    ip_addresses = local.green_backend_address_pool_ips
  }

  backend_http_settings {
    name                                = local.green_http_setting_name
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 80
    protocol                            = "Http"
    request_timeout                     = 60
    pick_host_name_from_backend_address = true
    probe_name                          = "nginx-ingress-probe"
  }

  tags = local.common_tags
}

