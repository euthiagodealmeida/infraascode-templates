resource "aws_ecr_repository" "this" {
  name = var.repository_name

  image_tag_mutability = var.image_tag_mutability
  force_delete         = var.force_delete

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  encryption_configuration {
    encryption_type = var.encryption_type
    kms_key         = var.kms_key_id
  }

  tags = merge(
    var.tags,
    {
      Name      = var.repository_name
      ManagedBy = "opentofu"
    }
  )
}
