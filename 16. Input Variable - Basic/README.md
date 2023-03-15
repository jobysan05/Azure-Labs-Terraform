## Introduction
- Understanding `input variables` within terraform
- Input variables serve as parameters for a Terraform module, allowing aspects of the module to be configured without chaging the source code while allowing modules to be shared between different configurations.

## versions.tf
```t
# Terraform Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "= 3.7.0" 
    }
  }
}

# Provider Block
provider "azurerm" {
 features {}          
}

```

## variables.tf
```t
# Input Variables
variable "lob" {
  description = "Line of Business"
  type = string
  default = "mylob"
}
# 2. Environment Name
variable "environment" {
  description = "Environment Name"
  type = string
  default = "dev"
}
# 3. Resource Group Name
variable "resoure_group_name" {
  description = "Resource Group Name"
  type = string
  default = "myrg"
}
# 4. Resource Group Location
variable "resoure_group_location" {
  description = "Resource Group Location"
  type = string
  default = "westus"
}
# 5. Virtual Network Name
variable "virtual_network_name" {
  description = "Virtual Network Name"
  type = string 
  default = "myvnet"
}
```

## main.tf
```t
# Create resource group
resource "azurerm_resource_group" "myrg" {
  name = "${var.lob}-${var.environment}-${var.resoure_group_name}"
  location = var.resoure_group_location
}

# Create Virtual Network
resource "azurerm_virtual_network" "myvnet" {
  name                = "${var.lob}-${var.environment}-${var.virtual_network_name}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
}
```

## Execute Terraform Commands
```t
# Terraform Init
terraform init

# Terraform Plan
terraform plan

# Terraform Apply
terraform apply

Observation: 
1. Resource Group name is created with the varible values from variables.tf file
2. Virtual Network name is created with the varible values from variables.tf file
```