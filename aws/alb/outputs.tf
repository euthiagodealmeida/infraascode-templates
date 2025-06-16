output "alb_id" {
  description = "The ID of the load balancer"
  value       = aws_lb.this.id
}

output "alb_arn" {
  description = "The ARN of the load balancer"
  value       = aws_lb.this.arn
}

output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.this.dns_name
}

output "alb_zone_id" {
  description = "The canonical hosted zone ID of the load balancer"
  value       = aws_lb.this.zone_id
}

output "target_group_arn" {
  description = "The ARN of the target group"
  value       = aws_lb_target_group.this.arn
}

output "target_group_name" {
  description = "The name of the target group"
  value       = aws_lb_target_group.this.name
}

output "http_listener_arn" {
  description = "The ARN of the HTTP listener"
  value       = aws_lb_listener.http.arn
}

output "https_listener_arn" {
  description = "The ARN of the HTTPS listener"
  value       = var.enable_https_listener ? aws_lb_listener.https[0].arn : null
}

output "alb_security_groups" {
  description = "The security groups assigned to the load balancer"
  value       = aws_lb.this.security_groups
}

output "alb_subnets" {
  description = "The subnets assigned to the load balancer"
  value       = aws_lb.this.subnets
}
