## Introduction
1. Create new subnet for the virtual network created in Section 7
2. Validating new subnet has been created
3. Delete resource when finished      


## Updating main.tf from Section 7
```t
resource "azurerm_resource_group" "Azurelab-rg-example" {
  name     = "AzureLab-RG-1"
  location = "westus"
}

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

# Creating new subnet
resource "azurerm_subnet" "Azurelab-subnet-example" {
  name                 = "AzureLab-subnet-1"
  resource_group_name  = azurerm_resource_group.Azurelab-rg-example.name
  virtual_network_name = azurerm_virtual_network.Azurelab-vn-example.name
  address_prefixes     = ["10.0.2.0/24"]
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
terraform destroy --target Azurelab-subnet-example

# Observation
New subnet for AzureLab-VN is created and deleted
```