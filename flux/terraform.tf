terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~>2.0"
    }
  }

  backend "azurerm" {
    storage_account_name = "terramateaksstack42"
    container_name       = "tfstate"
    resource_group_name  = "terramate-aks-stack"
    key                  = "flux.tfstate"
  }
}