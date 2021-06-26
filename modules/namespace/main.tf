provider "azurerm" {
  features {}
}

resource "kubernetes_namespace" "namespace" {
    
  metadata {
    
    labels = {
      mylabel = var.label
    }

    name = var.name
  }

 
}
