output "role_arn" {
  description = "ARN of the created IAM role"
  value       = module.ecs_task_role.role_arn
}

output "role_name" {
  description = "Name of the created IAM role"
  value       = module.ecs_task_role.role_name
}

output "role_id" {
  description = "ID of the created IAM role"
  value       = module.ecs_task_role.role_id
}
