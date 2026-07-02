module "network" {
  source = "./modules/network"

  environment = var.environment
  aws_region  = var.aws_region
}

module "iam" {
  source = "./modules/iam"

  environment = var.environment
}

module "ecr" {
  source = "./modules/ecr"

  environment              = var.environment
  backend_repository_name  = var.backend_repository_name
  frontend_repository_name = var.frontend_repository_name
}

module "eks" {
  source = "./modules/eks"

  environment          = var.environment
  cluster_name         = var.cluster_name
  kubernetes_version   = var.kubernetes_version
  node_instance_type   = var.node_instance_type
  node_count           = var.node_count
  cluster_role_arn     = module.iam.eks_cluster_role_arn
  node_role_arn        = module.iam.eks_node_role_arn
  public_subnet_ids    = module.network.public_subnet_ids
  private_subnet_ids   = module.network.private_subnet_ids

  depends_on = [
    module.iam
  ]
}
