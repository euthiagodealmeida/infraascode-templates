output "service_arn" {
  description = "ARN of the ECS service"
  value       = module.ecs_service.service_arn
}

output "service_name" {
  description = "Name of the ECS service"
  value       = module.ecs_service.service_name
}

output "service_cluster" {
  description = "Cluster name where the service is running"
  value       = module.ecs_service.service_cluster
}

output "service_task_definition" {
  description = "Task definition ARN used by the service"
  value       = module.ecs_service.service_task_definition
}

output "service_desired_count" {
  description = "Desired number of tasks for the service"
  value       = module.ecs_service.service_desired_count
}
