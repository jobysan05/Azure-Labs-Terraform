## Introduction
- Understanding how to provide input variable using a `env.tfvars` file with the `-var-file` CLI argument
- This is useful when there are multiple environments with environment specific configurations within each tf.vars files

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

## dev.tfvars
```t
lob = "lob-d-tfvars"
environment = "dev"
resoure_group_name = "rg-d-tfvars"
resoure_group_location = "westus"
virtual_network_name = "vnet-d-tfvars"
subnet_name = "subnet-d-tfvars"
```

## qa.tfvars
```t
lob = "lob-q-tfvars"
environment = "qa"
resoure_group_name = "rg-q-tfvars"
resoure_group_location = "westus"
virtual_network_name = "vnet-q-tfvars"
subnet_name = "subnet-q-tfvars"
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

## Execute Terraform Commands
```t
# Terraform Init
terraform init

# Terraform Plan
terraform plan -var-file="qa.tfvars" # Specify the config file for the specific environment resources are deployed to

# Terraform Apply
terraform apply -var-file="qa.tfvars"

Observation: 
1. Resources are created with variable values set in the `qa.tfvars` file and will overide default values set in the `variables.tf` file
```