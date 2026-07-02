output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "backend_repository_url" {
  value = module.ecr.backend_repository_url
}

output "frontend_repository_url" {
  value = module.ecr.frontend_repository_url
}
