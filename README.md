# Devops-Assessment

# Project Overview
- This project is a DevOps-based application with a frontend and backend microservice architecture.
- The backend exposes APIs for application status and health check (/ and /health).
- The frontend runs as a separate service and communicates with the backend API.
- Both services are containerized using Docker and can be run locally using Docker Compose.
- A CI/CD pipeline automates build, test, Docker image creation, tagging, and pushing to Amazon ECR/Azure ACR.
- GitHub Releases are used for version tracking of builds.
- Kubernetes is used for orchestration with deployments, services, and ingress (to be implemented).
- The backend connects to a private database, ensuring it is not publicly exposed.
- Infrastructure is managed using Terraform for provisioning AKS/EKS and related cloud resources.
- Troubleshooting details.
- Future improvements proposal.

The goal is to demonstrate a production-style DevOps workflow using cloud and automation tools.

# Frontend
The frontend is a simple web application running in a container.
- Displays a basic web page
- Calls backend API to check service status
- Helps verify if backend is reachable


# Backend
The backend is a REST API service running on port 8080.
It provides:
- / → Returns "Application is running"
- /health → Returns { "status": "ok" }

It is used to:
- Confirm service health
- Serve API response to frontend
- Frontend <-> Backend Connection

The frontend communicates with the backend using API calls.
- Used to verify service connectivity
- Helps ensure backend is running properly
- Demonstrates microservice communication


# CI/CD Pipeline
The CI/CD pipeline automates the full deployment process.
It performs:
- Code checkout from GitHub
- Run backend tests using pytest
- Build Docker images for frontend and backend
- Tag images using GitHub run number
- Push images to Amazon ECR
- Create GitHub release for version tracking
- Deploy to Kubernetes cluster

-> Secrets Management

All sensitive data like AWS credentials and tokens are stored securely using GitHub Secrets and cloud secret management tools. They are never exposed in code.

How Secrets Should Be Stored Safely?

Ans: Secrets such as passwords, API keys, and tokens must never be stored in code or Git repositories.

Instead, use secure secret management tools:
GitHub Secrets:
Used in GitHub Actions pipelines.
- Stored in repository settings
- Accessed using ${{ secrets.NAME }}
- Fully encrypted and hidden from logs

Jenkins Credentials:
Jenkins stores secrets in its internal credential store.
- Used inside pipelines by credential ID
- Supports passwords, tokens, SSH keys

Azure DevOps Variable Groups:
Stores secrets centrally for pipelines.
- Marked as “secret” to hide values
- Can be shared across pipelines

Azure Key Vault:
Cloud-based secure storage for secrets.
- Stores passwords, certificates, keys
- Access controlled using Azure Active Directory
- Common in production environments

AWS Secrets Manager:
AWS service for secret storage.
- Stores database credentials, API keys
- Supports automatic rotation
- Access controlled via IAM roles


# Kubernetes Setup
This project uses Kubernetes to run a frontend and backend application.
What is implemented?
1. Separate applications
    - Frontend and backend are deployed separately
    - Each has its own deployment file
2. Backend runs on port 8080
    - Backend application listens on port 8080
    - Kubernetes service connects to this port
3. Two replicas
    - Both frontend and backend run with 2 copies (pods)
    - This helps if one pod fails, another keeps running
4. Health checks (Readiness & Liveness)
    - Readiness probe → checks if app is ready to serve traffic
    - Liveness probe → restarts app if it stops working
5. Resource limits
    - Each app has CPU and memory limits
    - This prevents one app from using too much system resource
6. ConfigMap
    - Used to store normal settings (like URLs, config values)
    - Not used for sensitive data
7. Secret
    - Used for sensitive data like database username and password
    - Stored securely in Kubernetes
8. Image tag (no latest)
    - Docker images are not using latest
    - Each build has a version like:
        - backend:1
        - frontend:1
    - This comes from CI/CD pipeline
9. Ingress (external access)
    - Ingress is used to open the frontend to the internet
    - Users can access the frontend through a URL
10. Backend is internal only
    - Backend is NOT exposed to the internet
    - Only frontend can talk to backend inside cluster


# Private Database Connectivity (AWS RDS)
- The backend application connects to an AWS RDS database using the private RDS endpoint. Since both the EKS cluster and the RDS instance are deployed within the same VPC, the connection stays inside the AWS private network without using the public internet.
- The RDS database is deployed in a private subnet, while the Application Load Balancer (Ingress) is placed in a public subnet. This design ensures that users can access the application, but the database remains private.
- The backend connects to the database using the RDS private DNS endpoint, which is configured as an environment variable through a Kubernetes ConfigMap. This makes it easy to update the database endpoint without changing the application code.
- Access to the database is controlled using AWS Security Groups, which act as virtual firewalls. The RDS security group allows database traffic only from the EKS worker node security group on the required database port (5432 for PostgreSQL or 3306 for MySQL). No public IP addresses or internet access are allowed.
- Only the backend service can access the database. The frontend communicates only with the backend API, and all database operations are handled by the backend.
- Sensitive information such as the database username and password is stored securely using Kubernetes Secrets. These credentials are injected into the backend container as environment variables, keeping them separate from the application code.
- To verify that the database is not publicly accessible, Public Access is disabled in the RDS configuration, the database is deployed only in private subnets, and the security group does not allow inbound access from 0.0.0.0/0. This ensures that the database can only be accessed from the EKS cluster.


# Terraform
Terraform is used to provision the AWS infrastructure required for the application. The infrastructure is organized using custom modules for better maintainability.

The Terraform configuration will create the VPC, public and private subnets, Internet Gateway, NAT Gateway, route tables, Amazon ECR repositories, IAM roles and policies, Amazon EKS cluster, and an EKS Managed Node Group. Infrastructure settings such as the environment, region, cluster name, Kubernetes version, and node configuration are managed through Terraform variables. After a successful terraform apply, Terraform outputs useful information such as the cluster name, cluster endpoint, ECR repository URLs, and VPC ID.

