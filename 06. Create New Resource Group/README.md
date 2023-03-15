## Introduction
1. Create new resource group in azure via terraform
2. Validating new resource group has been created
3. Delete resource group when finished      

## Create file named version.tf
```t
terraform {
  required_version = ">=0.12"

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
```

## Create file named main.tf
```t
resource "azurerm_resource_group" "Azurelab-rg-example" {
  name     = "AzureLab-RG-1"
  location = "westus"
}
```

## Terraform commands
```t
# Initialize Terraform
terraform init

# Terraform Plan 
terraform plan

# Terraform Apply 
terraform apply

#Validation of resource group creation
az group show --name <resource_group_name>

#Destroy created resource group
terraform destroy

# Observation
New resource group is created


```
