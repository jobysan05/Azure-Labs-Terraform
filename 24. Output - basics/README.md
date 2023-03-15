## Introduction
- Understanding how to use `terraform output` block and how to implement it
- Redact sensitive values in output using `sensitive = true` in the output block

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
```

## terraform.tfvars
```t
lob = "lobtfvars"
environment = "dev"
resoure_group_name = "rgtfvars"
resoure_group_location = "westus"
virtual_network_name = "vnettfvars"
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

## outputs.tf
```t
# Output resource group
output "resource_group_id" {
  description = "Resource Group ID"
  value = azurerm_resource_group.myrg.id 
}

output "resource_group_name" {
  description = "Resource Group name"
  value = azurerm_resource_group.myrg.name  
}

# Output virtual network
output "virtual_network_name" {
  description = "Virutal Network Name"
  value = azurerm_virtual_network.myvnet.name 
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
1. Outputs (resource group id, resource group name and virtual network name) can be obeserved in the CLI terminal
```

## Query Terraform Outputs
- `terraform output` command can be used to query the state file
```t
# Terraform Output Commands
terraform output
terraform output resource_group_id
terraform output virtual_network_name
```