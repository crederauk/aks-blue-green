data "terraform_remote_state" "base_infra" {
  backend = "azurerm"

  config = {
    resource_group_name  = "dev_tf_state"
    storage_account_name = "devtfstatesa001"
    container_name       = "aks-state"
    key                  = "aks_blue_green_base_infra.tfstate"
  }
}
