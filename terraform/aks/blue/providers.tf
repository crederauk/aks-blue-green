terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.25.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.7.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.blue_cluster.kube_admin_config.0.host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.blue_cluster.kube_admin_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.blue_cluster.kube_admin_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.blue_cluster.kube_admin_config.0.cluster_ca_certificate)
  }
}
