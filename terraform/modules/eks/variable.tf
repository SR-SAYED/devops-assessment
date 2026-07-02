variable "environment" {
  type = string
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

variable "cluster_role_arn" {
  description = "IAM role ARN for the EKS control plane"
  type        = string
}

variable "node_role_arn" {
  description = "IAM role ARN for the EKS worker nodes"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for the EKS control plane"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for the EKS worker nodes"
  type        = list(string)
}
