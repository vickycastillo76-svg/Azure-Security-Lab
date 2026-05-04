terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0" # Usamos la versión 3.0 estable
    }
  }
}

provider "azurerm" {
  features {} # Esta línea es obligatoria para activar las funciones de Azure
}
