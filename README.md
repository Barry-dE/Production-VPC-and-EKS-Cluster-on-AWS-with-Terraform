# Production-VPC-and-EKS-Cluster-on-AWS-with-Terraform

## Project Overview
This project is a modular, production-grade Terraform codebase for deploying a secure, highly available, and scalable Kubernetes (EKS) cluster within a VPC on AWS. It automates the creation of all necessary cloud resources, including networking, IAM roles, and state management, following AWS and industry best practices.

## Folder Structure
VPC + EKS/
├── backend/
│   ├── main.tf             # Terraform remote backend (S3 & DynamoDB) configuration
│   └── variables.tf
├── modules/
│   ├── vpc/
│   │   ├── main.tf         # VPC, subnets, NAT, IGW, route tables, etc.
│   │   ├── variables.tf
│   │   └── outputs.tf      # Prints VPC, Public, and Private Subnet IDs
│   └── eks/
│       ├── main.tf         # EKS cluster, IAM roles, node groups
│       ├── variables.tf
│       └── outputs.tf      # Prints the cluster endpoint and cluster name
├── main.tf                 # Root module: wires together vpc & eks modules
├── variables.tf            # Root input variables (e.g., region, cluster name)
└── outputs.tf              # Root outputs for EKS access and networking
