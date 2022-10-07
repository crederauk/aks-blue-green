resource "azurerm_kubernetes_cluster" "blue_cluster" {
  name                = "${local.name_prefix}-cluster-${local.cluster}"
  resource_group_name = data.terraform_remote_state.base_infra.outputs.aks_rg.name
  location            = data.terraform_remote_state.base_infra.outputs.aks_rg.location
  dns_prefix          = "${local.name_prefix}-blue"

  default_node_pool {
    name           = "default"
    node_count     = 1
    vm_size        = "Standard_D2_v2"
    vnet_subnet_id = data.terraform_remote_state.base_infra.outputs.sn.blue.id
  }

  network_profile {
    service_cidr       = "172.0.0.0/24"
    docker_bridge_cidr = "172.0.0.255/32"
    dns_service_ip     = "172.0.0.250"
    network_plugin     = "kubenet"
  }

  # azure_active_directory_role_based_access_control {
  #   managed = true
  #   admin_group_object_ids = ["d9ff49a5-bb4d-4893-944d-fabc7d05f4a0"]
  #   azure_rbac_enabled = true
  # }

  identity {
    type = "SystemAssigned"
  }

  tags = local.common_tags
}
