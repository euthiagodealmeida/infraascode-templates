resource "aws_security_group" "this" {
  name_prefix = var.name_prefix != "" ? var.name_prefix : "${var.name}-"
  name        = var.name_prefix != "" ? null : var.name
  description = var.description
  vpc_id      = var.vpc_id

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
