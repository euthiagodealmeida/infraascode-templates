output "alb_dns_name" {
  description = "DNS name of the load balancer"
  value       = module.lab-alb.alb_dns_name
}

output "alb_zone_id" {
  description = "Zone ID of the load balancer"
  value       = module.lab-alb.alb_zone_id
}

output "alb_arn" {
  description = "ARN of the load balancer"
  value       = module.lab-alb.alb_arn
}

output "target_group_arn" {
  description = "ARN of the target group"
  value       = module.lab-alb.target_group_arn
}

output "https_listener_arn" {
  description = "ARN of the HTTPS listener"
  value       = module.lab-alb.https_listener_arn
}

output "http_listener_arn" {
  description = "ARN of the HTTP listener"
  value       = module.lab-alb.http_listener_arn
}