## Introduction
- Implement `for_each` with set of strings
- Understand `toset` funtion

## toset funtion
- `toset` converts its argument to a set value. In short, it does an explicit type conversion to normalize the types
- Terraform's concept of a set requires all of the elements to be of the same type, mixed-typed elements will be converted to the most general type
- Set collections are unordered and cannot contain duplicate values

```t
# Terraform console
terraform console

# All Strings to Strings
toset(["James", "Max", "Elena"])

# Mixed Type (Strings and Numbers) - Converted to Strings 
toset(["James", "Max", 123, 456])

# Removes duplicates (Set collections are unordered and cannot contain duplicate values) 
toset(["a", "j", "r", "a", "m"])

# Also arranges in the order (The order provided will be gone)
toset([5, 90, 11, 88, 27, 19, 76, 5, 90])
```

## Using for_each meta-argument

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

## resource-group.tf - Implementing for_each with Maps
```t
# Creating Resource Group utilizing for_each meta-argument
resource "azurerm_resource_group" "myrg" {
  for_each = toset(["eastus", "eastus2", "westus"])
  name = "myrg-${each.value}" 
  location = each.key 
}
```

## Execute Terraform Commands
```t
# Terraform Init
terraform init

# Terraform Plan
terraform plan
Observation: 
1. 3 Resource Groups Resources will be generated in plan

# Terraform Apply
terraform apply

Observation: 
1. 3 Resource Group will be created
```