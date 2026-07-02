resource "aws_ecr_repository" "backend" {
  name = var.backend_repository_name

  image_scanning_configuration {
    scan_on_push = true
  }

  image_tag_mutability = "MUTABLE"

  tags = {
    Name = "${var.environment}-backend-ecr"
  }
}

resource "aws_ecr_repository" "frontend" {
  name = var.frontend_repository_name

  image_scanning_configuration {
    scan_on_push = true
  }

  image_tag_mutability = "MUTABLE"

  tags = {
    Name = "${var.environment}-frontend-ecr"
  }
}