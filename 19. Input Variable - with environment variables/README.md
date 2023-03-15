## Introduction
- Understanding how to use `environment variables` during plan/apply to override default variables with user specific variables

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

variable "environment" {
  description = "Environment Name"
  type = string
  default = "dev"
}

variable "resoure_group_name" {
  description = "Resource Group Name"
  type = string
  default = "myrg"
}

variable "resoure_group_location" {
  description = "Resource Group Location"
  type = string
  default = "westus"
}

variable "virtual_network_name" {
  description = "Virtual Network Name"
  type = string 
  default = "myvnet"
}

variable "subnet_name" {
  description = "Virtual Network Subnet Name"
  type = string 
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

# Create Subnet
resource "azurerm_subnet" "mysubnet" {
  name                 = "${azurerm_virtual_network.myvnet.name}-${var.subnet_name}"
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes     = ["10.0.2.0/24"]
}
```

## Set environment variables through terminal
```t
export TF_VAR_resoure_group_name=rgenv
export TF_VAR_resoure_group_location=westus2
export TF_VAR_virtual_network_name=vnetenv
export TF_VAR_subnet_name=subnetenv
echo $TF_VAR_resoure_group_name, $TF_VAR_resoure_group_location, $TF_VAR_virtual_network_name, $TF_VAR_subnet_name
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
1. Resources are created with the set environment variables in terraform apply
```

## Unset environment variables through terminal
```t
unset TF_VAR_resoure_group_name
unset TF_VAR_resoure_group_location
unset TF_VAR_virtual_network_name
unset TF_VAR_subnet_name
echo $TF_VAR_resoure_group_name, $TF_VAR_resoure_group_location, $TF_VAR_virtual_network_name, $TF_VAR_subnet_name
```