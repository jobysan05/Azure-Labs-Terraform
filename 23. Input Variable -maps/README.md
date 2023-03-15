## Introduction
- Understanding how to implement complex type contructors like `maps`

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

resource "random_string" "myrandom" {
  length = 6
  upper = false 
  special = false
  number = false   
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

variable "public_ip_sku" {
  description = "Azure Public IP Address SKU"
  type = map(string)
  default = {
    "westus" = "Basic"
    "westus2" = "Standard" 
  }
}
```

## terraform.tfvars
```t
lob = "lobtfvars"
environment = "dev"
resoure_group_name = "rgtfvars"
resoure_group_location = "westus2"
virtual_network_name = "vnettfvars"
subnet_name = "subnettfvars"
virtual_network_address_space = ["10.3.0.0/16", "10.4.0.0/16", "10.5.0.0/16"]
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

# Create public IP
resource "azurerm_public_ip" "mypublicip" {
  name                = "mypublicip-1"
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  allocation_method   = "Static"
  domain_name_label   = "app1-vm-${random_string.myrandom.id}"
  sku = lookup(var.public_ip_sku, var.resoure_group_location)   # lookup public_ip_sku variable "Standard" since we are inputing resoure_group_location as 'westus2'
                                                                # in terraform.tfvars file. If resoure_group_location = "westus" then public_ip_sku = "Basic"
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
1. Resources are created with variable values set in the `terraform.tfvars` while public_ip is created based on the resoure_group_location variable in the `terraform.tfvars` file
```