variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "production"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "my-cluster"
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.30"
}

variable "node_instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "node_count" {
  description = "Number of worker nodes"
  type        = number
  default     = 2
}

variable "backend_repository_name" {
  description = "Backend ECR repository"
  type        = string
  default     = "backend"
}

variable "frontend_repository_name" {
  description = "Frontend ECR repository"
  type        = string
  default     = "frontend"
}
