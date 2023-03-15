terraform {
  required_version = ">=1.1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "Azurelab-rg-example" {
  name     = "AzureLab-RG-1"
  location = "westus"
}
