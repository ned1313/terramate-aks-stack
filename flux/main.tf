provider "helm" {
  kubernetes {
    host                   = "https://${data.terraform_remote_state.aks.outputs.host}"
    client_certificate     = base64decode(data.terraform_remote_state.aks.outputs.client_certificate)
    client_key             = base64decode(data.terraform_remote_state.aks.outputs.client_key)
    cluster_ca_certificate = base64decode(data.terraform_remote_state.aks.outputs.cluster_ca_certificate)
  }
}

data "terraform_remote_state" "aks" {
  backend = "azurerm"

  config = {
    storage_account_name = "tmc30374sa"
    container_name       = "tfstate"
    resource_group_name  = "tmc-30374-rg"
    key                  = "aks.tfstate"
    use_azuread_auth = true
  }
}

resource "helm_release" "flux" {
  repository       = "https://fluxcd-community.github.io/helm-charts"
  chart            = "flux2"
  name             = "flux2"
  namespace        = "flux-system"
  create_namespace = true

}