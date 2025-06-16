resource "aws_iam_role" "this" {
  name                  = var.name
  description          = var.description
  assume_role_policy   = var.assume_role_policy
  max_session_duration = var.max_session_duration
  path                 = var.path
  permissions_boundary = var.permissions_boundary
  force_detach_policies = var.force_detach_policies

  tags = merge(
    var.tags,
    {
      Name      = var.name
      ManagedBy = "opentofu"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}
