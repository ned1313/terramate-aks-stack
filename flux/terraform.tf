terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~>2.0"
    }
  }

  backend "azurerm" {
    storage_account_name = "tmc30374sa"
    container_name       = "tfstate"
    resource_group_name  = "tmc-30374-rg"
    key                  = "flux.tfstate"
    use_azuread_auth = true
  }
}