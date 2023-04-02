
## Assignment 3: Deploy a highly available and scalable web application on Azure using Terraform

## Description:
You have been tasked with deploying a highly available and scalable web application on Azure using Terraform. The web application must be deployed across multiple availability zones in a single Azure region, and must be able to handle high traffic loads.

## Tasks:
- Create an Azure Resource Group to contain all resources required for the deployment.
- Use Terraform to create an Azure Virtual Network with three subnets: one for the web servers, one for the application servers, and one for the database servers.
- Create an Azure Load Balancer to distribute incoming traffic across the web servers.
- Use Terraform to create an Azure Availability Set for the web servers to ensure high availability.
- Deploy a minimum of two virtual machines to the web server subnet, configure them as web servers, and attach them to the load balancer.
- Use Terraform to deploy a MySQL database in the database subnet, and configure it for high availability.
- Deploy a minimum of two virtual machines to the application server subnet, configure them as application servers, and connect them to the database.
- Use Terraform to create an Azure Application Gateway to protect the web servers and control access to the application.
- Configure the Azure Application Gateway to use SSL/TLS encryption for incoming traffic.
- Deploy a minimum of two virtual machines to the database server subnet, configure them as database servers, and attach them to the MySQL database.

## Deliverables:
- Terraform code to deploy the Azure infrastructure (add comments to explain the process).
- A validation report showing that the infrastructure is functioning correctly (screenshots of portal).

## Constraints:

- The web application must be deployed in a single Azure region.
- The infrastructure must be deployed using Terraform.
- The deployment must be highly available and scalable, and must be able to handle high traffic loads.
