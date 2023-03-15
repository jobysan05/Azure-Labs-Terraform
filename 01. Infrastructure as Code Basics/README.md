# Infrastructure as Code Basics

## Problems with traditional way of managing infrastructure
- Time required for building multiple environments
- Issues teams face with different environments
- Scale-Up and Scale-Down on-demand

## Advantages of IaC with Terraform
- Visibility: IaC serves as a very clear reference of what resources are created and what their settings are.
- Stability: IaC combined with version control prevents accidently changing the wrong setting or deleting the wrong resource.
- Scalability: Write a template once that can be reused for multiple services making it easier to scale horizontally.
- Security: Reusing one unified secured architecture and know that each deployed version follows the same settings.
- Audit: Maintains a record of what is created in real world cloud environments using state files.