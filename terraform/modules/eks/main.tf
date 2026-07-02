resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  version  = var.kubernetes_version

  vpc_config {
    subnet_ids = concat(var.public_subnet_ids, var.private_subnet_ids)

    endpoint_private_access = true
    endpoint_public_access  = true
  }

  tags = {
    Name = "${var.environment}-eks-cluster"
  }
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.environment}-node-group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnet_ids

  instance_types = [var.node_instance_type]

  scaling_config {
    desired_size = var.node_count
    min_size     = 2
    max_size     = 4
  }

  tags = {
    Name = "${var.environment}-node-group"
  }
}
