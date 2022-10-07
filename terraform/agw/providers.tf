terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.25.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-tf-st"
    storage_account_name = "sttfstatealz"
    container_name       = "aks-state"
    key                  = "aks_blue_green_agw.tfstate"
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id

  features {}
  skip_provider_registration = true
}
