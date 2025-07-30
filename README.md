# Production-VPC-and-EKS-Cluster-on-AWS-with-Terraform

## Project Overview
This project is a modular, production-grade Terraform codebase for deploying a secure, highly available, and scalable Kubernetes (EKS) cluster within a VPC on AWS. It automates the creation of all necessary cloud resources, including networking, IAM roles, and state management, following AWS and industry best practices.

## Folder Structure
This project is organized into three main parts:

```backend/``` – Contains configuration files for setting up the remote Terraform backend using S3 (for state storage) and DynamoDB (for state locking).

  ```main.tf```: Defines the backend setup.

  ```variables.tf```: Contains backend-specific variables.

```modules/``` – Contains reusable, modular Terraform code for infrastructure components.

```vpc/```: Provisions the AWS VPC, public and private subnets, NAT gateways, Internet Gateway (IGW), and route tables.

```main.tf```: Core logic for the VPC.

```variables.tf```: Inputs for customizing the VPC module.

```outputs.tf```: Exposes subnet IDs and VPC ID for use in other modules.

```eks/```: Provisions the EKS cluster, IAM roles, node groups, and autoscaling settings.

```main.tf```: Main cluster configuration.

```variables.tf```: Inputs for customizing the EKS module.

```outputs.tf```: Outputs the EKS cluster name and endpoint.



