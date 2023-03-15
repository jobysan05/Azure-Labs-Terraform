Only use resource group creating
have code as files


## Introduction
1. Understand resource syntax

## Using main.tf from Section 7
```t
resource "azurerm_resource_group" "Azurelab-rg-example" {
  name     = "AzureLab-RG-1"
  location = "westus"
}

# Creating new virtual network
resource "azurerm_virtual_network" "Azurelab-vn-example" {
  name                = "AzureLab-VN-1"
  location            = azurerm_resource_group.Azurelab-rg-example.location
  resource_group_name = azurerm_resource_group.Azurelab-rg-example.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
  tags = {
    "Name" = "vnet-1"
  }
}
```

## Resource Syntax
1. Resource Type: `azurerm_virtual_network` - Determines the kind of infrastructure object it manages, arguments and attributes the resource supports.
2. Resource Local Name: `Azurelab-vn-example` - Used to refer to this resource in the same module but has no significance outside the module's scope.
3. Resource Arguments: `address_space` or `resource_group_name` - This is specific to resource type (Arguments can be found for specific resource type using the hashicorp [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network)) based on azurerm version.

## Resource Behavior
1. Creation of resources
```t
# Initialize Terraform
terraform init

# Observation
Successfully downloaded providers in .terraform folder
Created lock file called .terraform.lock.hcl

# Terraform Plan 
terraform plan

# Observation
Shows that new resources are created as `+ create`
Shows `Plan: # to add, 0 to change, 0 to destroy.`

# Terraform Apply 
terraform apply

# Observation
Creates a state file called `terraform.tfstate` in the local working directory
Shows `Apply complete! Resources: # added, 0 changed, 0 destroyed.`
```

2. Terraform Update In-Place
```t
resource "azurerm_virtual_network" "Azurelab-vn-example" {
  name                = "AzureLab-VN-1"
  location            = azurerm_resource_group.Azurelab-rg-example.location
  resource_group_name = azurerm_resource_group.Azurelab-rg-example.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
  tags = {
    "Name" = "vnet-1"
    "Environment" = "Dev"   # updated configuration
  }
}
```
```t
# Terraform Plan 
terraform plan

# Observation
Shows that new resources are updated as `~ update in-place`
Shows `Plan: 0 to add, # to change, 0 to destroy.`

# Terraform Apply 
terraform apply

# Observation
Shows `Apply complete! Resources: 0 added, # changed, 0 destroyed.`
```

3. Destroy and Re-create Resources
```t
resource "azurerm_virtual_network" "Azurelab-vn-example" {
  name                = "AzureLab-VN-test"   # updated virtual network name
  location            = azurerm_resource_group.Azurelab-rg-example.location
  resource_group_name = azurerm_resource_group.Azurelab-rg-example.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
  tags = {
    "Name" = "vnet-1"
    "Environment" = "Dev"   
  }
}
```
```t
# Terraform Plan 
terraform plan

# Observation
Shows that resource must be replaced  as `-/+ destroy and then create replacement`
Shows `Plan: # to add, 0 to change, # to destroy.`

# Terraform Apply 
terraform apply

# Observation
Shows `pply complete! Resources: # added, 0 changed, # destroyed.`
```

4. Destroy Resources
```t
# Terraform Destroy 
terraform destroy

# Observation
Shows that resource is destroyed as - destroy
Shows Destroy complete! Resources: # destroyed.
```

## Terraform State file
1. It is the underlying database containing the resource(s) information which are provisioned using terraform.
2. Stores bindings between objects in a remote system and resource instances declared in the configuration.
3. When terraform creates a remote object in response to a change of configuration, it will record the identity of that remote object against a particular resource instance, and then potentially update or delete that object based on future configuration changes.
4. State files are created locally in the working directory.