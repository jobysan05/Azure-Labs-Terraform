## Introduction
- Code in the terraform language is stored in plain text files with the .tf file extension.
- There is a JSON-based variant of the language that is named with the .tf.json file extension.
- Files containing terraform code is called as Terraform Configuration Files or Terraform Manifests.


## Terraform Configuration Language Syntax
- Blocks
    1. Containers for other content and usually represent the configuration of some kind of object, like a resource.
    2. Blocks have a block type, can have zero or more labels, and have a body that contains any number of arguments and nested blocks.
- Arguments
    1. Assign a value to a name.
    2. They appear within blocks.
    3. Arguments can be `required` or `optional`
    4. Attribues format looks like `resource_type.resource_name.attribute_name`
- Identifiers
    1. Argument names, block type names, and the names of most Terraform-specific constructs like resources, input variables, etc. are all identifiers.
    2. Identifiers can contain letters, digits, underscores (_), and hyphens (-).
    3. The first character of an identifier must not be a digit, to avoid ambiguity with literal numbers.
- Comments
    1. Terraform language supports three different syntaxes for comments:
        - `#` begins a single-line comment, ending at the end of the line.
        - `//` also begins a single-line comment, as an alternative to #.
        - `/*` and `*/` are start and end delimiters for a comment that might span over multiple lines.


```t
# Template
<BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>"   {
  # Block body
  <IDENTIFIER> = <EXPRESSION> # Argument
}

# Azure Example
# Create a resource group
resource "azurerm_resource_group" "myrg" { # Resource BLOCK
  name = "myrg-1" # Argument
  location = "West US" # Argument 
}
# Create Virtual Network
resource "azurerm_virtual_network" "myvnet" { # Resource BLOCK
  name                = "myvnet-1" # Argument
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.myrg.location # Argument with value as expression
  resource_group_name = azurerm_resource_group.myrg.name # Argument with value as expression
}
```
