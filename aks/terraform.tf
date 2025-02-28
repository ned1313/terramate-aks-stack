terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    storage_account_name = "tmc30374sa"
    container_name       = "tfstate"
    resource_group_name  = "tmc-30374-rg"
    key                  = "aks.tfstate"
    use_azuread_auth     = true
  }
}