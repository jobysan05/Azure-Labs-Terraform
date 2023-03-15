## Introduction
- Implement `for_each` chaining
- Because a resource using for_each appears as a map of objects or set of strings when used in expressions elsewhere, you can directly use one resource as the for_each of another in situations where there is a one-to-one relationship between the two sets of objects

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

## main.tf
```t
# Create resource group
resource "azurerm_resource_group" "myrg" {
  name = "myrg-1"
  location = "westus"
}

# Create Public IP Address
resource "azurerm_public_ip" "mypublicip" {
  #count = 2  
  for_each = toset(["vm1", "vm2"])
  name                = "mypublicip-${each.key}"
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  allocation_method   = "Static"
  domain_name_label = "app1-${each.key}-${random_string.myrandom.id}"  
}

# Create Network Interface
resource "azurerm_network_interface" "myvmnic" {
  #count = 2
  for_each = toset(["vm1", "vm2"])  
  name                = "vmnic-${each.key}"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.mypublicip[each.key].id
  }
}

# Creating Windows Virtual Machine
resource "azurerm_windows_virtual_machine" "mywindowsvm" {
  for_each = azurerm_network_interface.myvmnic
  depends_on = [azurerm_network_interface.myvmnic]
  name                = "mywindowsvm-${each.key}"
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "adminpassword"
  network_interface_ids = [azurerm_network_interface.myvmnic[each.key].id]

  os_disk {
    name = "osdisk${each.key}"
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

# Terraform Apply
terraform apply

Observation: 
1. Azure Resource Group created
2. Azure Virtual Network created
3. Azure Subnet created
4. Azure Public IP - 2 Resources created as specified in count
5. Azure Network Interface - 2 Resources created as specified in count
6. Azure Linux Virtual Machine - - 2 Resources created as specified in count
```