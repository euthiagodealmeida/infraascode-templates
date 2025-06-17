# HTTP Listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = var.enable_http_redirect && var.enable_https_listener ? "redirect" : "forward" # For security best practices, it's recommended to redirect HTTP traffic to HTTPS.

    dynamic "redirect" {
      for_each = var.enable_http_redirect && var.enable_https_listener ? [1] : []
      content {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }

    dynamic "forward" {
      for_each = var.enable_http_redirect && var.enable_https_listener ? [] : [1]
      content {
        target_group {
          arn = aws_lb_target_group.this.arn
        }
      }
    }
  }

  tags = var.tags
}

# HTTPS Listener
resource "aws_lb_listener" "https" {
  count = var.enable_https_listener ? 1 : 0

  load_balancer_arn = aws_lb.this.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn # Make sure to have a valid certificate ARN if HTTPS is enabled

  default_action {
    type = "forward"
    forward {
      target_group {
        arn = aws_lb_target_group.this.arn
      }
    }
  }

  tags = var.tags
}
