resource "aws_lb_target_group" "this" {
  name     = var.target_group_name
  port     = var.target_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = var.healthy_threshold
    interval            = var.health_check_interval
    matcher             = var.health_check_matcher
    path                = var.health_check_path
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = var.health_check_timeout
    unhealthy_threshold = var.unhealthy_threshold
  }

  tags = merge(
    var.tags,
    {
      Name      = var.target_group_name
      ManagedBy = "opentofu"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}
