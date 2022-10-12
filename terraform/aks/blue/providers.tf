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

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.14.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "dev_tf_state"
    storage_account_name = "devtfstatesa001"
    container_name       = "aks-state"
    key                  = "aks_blue.tfstate"
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
  skip_provider_registration = true
}

provider "helm" {
  kubernetes {
    # username               = azurerm_kubernetes_cluster.blue_cluster.kube_config.0.username
    # password               = azurerm_kubernetes_cluster.blue_cluster.kube_config.0.password
    # host                   = azurerm_kubernetes_cluster.blue_cluster.kube_config.0.host
    # client_certificate     = base64decode(azurerm_kubernetes_cluster.blue_cluster.kube_config.0.client_certificate)
    # client_key             = base64decode(azurerm_kubernetes_cluster.blue_cluster.kube_config.0.client_key)
    # cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.blue_cluster.kube_config.0.cluster_ca_certificate)
    host                   = azurerm_kubernetes_cluster.blue_cluster.kube_admin_config.0.host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.blue_cluster.kube_admin_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.blue_cluster.kube_admin_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.blue_cluster.kube_admin_config.0.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.blue_cluster.kube_admin_config.0.host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.blue_cluster.kube_admin_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.blue_cluster.kube_admin_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.blue_cluster.kube_admin_config.0.cluster_ca_certificate)
}
