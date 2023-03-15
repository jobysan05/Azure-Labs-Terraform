## Introduction
- Implement meta argument `count`
- Terraform will create the number of resources specified within the count argument
- `count.index` is the distinct index number (starting with 0) corresponding to the instance
- Cannot use both `for_each` and `count` simultaneously within a resource


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
    random = {
      source = "hashicorp/random"
      version = ">= 3.0"
    }
  }
}

# Provider Block
provider "azurerm" {
 features {}          
}

# Random String Resource
resource "random_string" "myrandom" {
  length = 6
  upper = false 
  special = false
  number = false 
}

```

## main.tf - Implementing count to create multiple resources
```t
# Create resource group
resource "azurerm_resource_group" "myrg" {
  name = "myrg-${count.index}"
  location = "West US"
  count = 3
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
2. Verify that count.index number for each resource group

# Terraform Apply
terraform apply

Observation: 
1. 3 Resource Group will be created
```

## main.tf - Implementing count for public ip and associating resources with splat expression [*]
```t
# Create resource group
resource "azurerm_resource_group" "myrg" {
  name = "myrg-1"
  location = "West US"
}

# Create Azure Public IP Address
resource "azurerm_public_ip" "mypublicip" {
  count = 2
  name                = "mypublicip-${count.index}"
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  allocation_method   = "Static"
  domain_name_label = "app1-vm-${count.index}-${random_string.myrandom.id}"  
}

# Create Network Interface
resource "azurerm_network_interface" "myvmnic" {
  count = 2
  name                = "vmnic-${count.index}"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = element(azurerm_public_ip.mypublicip[*].id, count.index)
  }
}

# Creating Windows Virtual Machine
resource "azurerm_windows_virtual_machine" "mywindowsvm" {
  name                = "mywindowsvm-1"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  location            = azurerm_resource_group.resourcegroup.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "adminpassword"
  network_interface_ids = [
    azurerm_network_interface.myvmnic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
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
2. Verify that count.index number for each resource group

# Terraform Apply
terraform apply

Observation: 
1. 3 Resource Group will be created
```