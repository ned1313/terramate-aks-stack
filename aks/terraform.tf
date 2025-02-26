terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    storage_account_name = "terramateaksstack42"
    container_name       = "tfstate"
    resource_group_name  = "terramate-aks-stack"
    key                  = "aks.tfstate"
  }
}