## Terraform Block
1. Specifying a required terraform CLI version
2. Specifying provider requirements and versions

# Terraform Block Example
```t
terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}
```

## Provider Block
1. Relies on providers to interact with remote sytem by installing providers (Ex: azurerm)

# Provider Block Example
```t
provider "azurerm" {
  features {} #Configuration of certain resource behaviors
}
```