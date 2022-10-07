data "terraform_remote_state" "base_infra" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-tf-st"
    storage_account_name = "sttfstatealz"
    container_name       = "aks-state"
    key                  = "aks_blue_green_base_infra.tfstate"
  }
}
