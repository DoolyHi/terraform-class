resource "aws_ecr_repository" "terraform-ecr" {
  name                 = "terraform-ecr"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  tags = {
    Name = "terraform-ecr"
  }
}