## Introduction
- Provisioning of Azure Windows Virtual Machine


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

## main.tf - creation of windows virtual machine
```t
# Creating Resource Group
resource "azurerm_resource_group" "myrg" {
  name     = "myrg-1"
  location = "West US"
}

# Creating Virtual Network
resource "azurerm_virtual_network" "myvnet" {
  name                = "myvnet-1"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
}

# Creating Subnet
resource "azurerm_subnet" "mysubnet" {
  name                 = "mysubnet-1"
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Creating Network Interface
resource "azurerm_network_interface" "myvmnic" {
  name                = "vmnic"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
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
1. Resource Group, Virtual Network, Subnet and Network Interface will be generated in plan
2. Windows Virtual Machine will be generated in plan

# Terraform Apply
terraform apply

Observation: 
1. Resource Group, Virtual Network, Subnet, Network Interface and Virtual Machine will be created
```