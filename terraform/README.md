# Terraform
This folder contains the Terraform code used to provision the AWS infrastructure for the application.

## What was implemented
- Used custom Terraform modules to organize the infrastructure.
- Created a VPC for the application.
- Created two public subnets and two private subnets across different Availability Zones.
- Configured an Internet Gateway for public internet access.
- Configured a NAT Gateway to allow resources in private subnets to access the internet.
- Created public and private route tables with subnet associations.
- Created Amazon ECR repositories for the frontend and backend Docker images.
- Created the required IAM roles and IAM policy attachments for the EKS cluster and worker nodes.
- Provisioned an Amazon EKS cluster.
- Provisioned an EKS Managed Node Group to run Kubernetes workloads.
- Added Terraform variables to configure the environment, AWS region, cluster name, Kubernetes version, node instance type, node count, networking, and repository names.
- Added Terraform outputs to display useful infrastructure information such as the cluster name, cluster endpoint, ECR repository URLs, and VPC ID after a successful `terraform apply`.

