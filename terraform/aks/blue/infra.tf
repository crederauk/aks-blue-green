resource "azurerm_kubernetes_cluster" "blue_cluster" {
  name                = "${local.name_prefix}-cluster-${local.cluster}"
  resource_group_name = data.terraform_remote_state.base_infra.outputs.aks_rg.name
  location            = data.terraform_remote_state.base_infra.outputs.aks_rg.location

  default_node_pool {
    name           = "default"
    node_count     = 1
    vm_size        = "Standard_D2_v2"
    vnet_subnet_id = data.terraform_remote_state.base_infra.outputs.sn.blue.id
  }

  identity {
    type = "SystemAssigned"
  }

  tags = local.common_tags
}
