resource "aws_lb" "this" {
  name               = var.alb_name
  internal           = var.internal # internet-facing or internal ALB
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids

  enable_deletion_protection = var.enable_deletion_protection

  tags = merge(
    var.tags,
    {
      Name      = var.alb_name
      ManagedBy = "terraform"
    }
  )
}
