## Introduction
1. Create new virtual network in azure via terraform
2. Validating new virtual network has been created
3. Delete virtual network when finished      


## Updating main.tf from Section 6
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

## Terraform commands
```t
# Initialize Terraform
terraform init

# Terraform Plan 
terraform plan

# Terraform Apply 
terraform apply

#Destroy created virtual network
terraform destroy --target Azurelab-vn-example

# Observation
New virtual network is created and deleted
```