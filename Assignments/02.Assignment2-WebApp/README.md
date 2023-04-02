
## Assignment 2: Deploy a simple web application on Azure using Terraform

## Description:
You have been tasked with deploying a simple web application on Azure using Terraform. The web application consists of a single web server and a backend database.

## Tasks:
- Create an Azure Resource Group to contain all resources required for the deployment.
- Use Terraform to create an Azure Virtual Network with two subnets: one for the web server and one for the database.
- Deploy a virtual machine to the web server subnet, configure it as a web server, and attach it to a public IP address.
- Use Terraform to deploy a MySQL database in the database subnet.
- Configure the web server to connect to the database and serve the web application.
- Use Terraform to create a security group to restrict incoming traffic to the web server.
- Configure the security group to allow incoming traffic only on port 80 for HTTP requests.
- Use Terraform to create a network security group to restrict incoming traffic to the database.
- Configure the network security group to allow incoming traffic only on port 3306 for MySQL requests.

## Deliverables:
- Terraform code to deploy the Azure infrastructure (add comments to explain the process).
- A validation report showing that the infrastructure is functioning correctly (screenshots of portal).

## Constraints:

- The web application must be deployed in a single Azure region.
- The infrastructure must be deployed using Terraform.

