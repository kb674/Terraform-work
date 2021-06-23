terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~> 2.46.0"

        }
    }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "k8group" {
  name     = "k8group"
  location = "uksouth"
}

resource "azurerm_kubernetes_cluster" "k8cluster" {
  name                = "k8cluster"
  location            = azurerm_resource_group.k8group.location
  resource_group_name = azurerm_resource_group.k8group.name
  dns_prefix          = "exampleaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.k8cluster.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.k8cluster.kube_config_raw
  sensitive = true
}