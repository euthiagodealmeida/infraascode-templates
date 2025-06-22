output "service_arn" {
  description = "ARN of the ECS service"
  value       = aws_ecs_service.this.id
}

output "service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.this.name
}

output "service_cluster" {
  description = "Cluster name where the service is running"
  value       = aws_ecs_service.this.cluster
}

output "service_task_definition" {
  description = "Task definition ARN used by the service"
  value       = aws_ecs_service.this.task_definition
}

output "service_desired_count" {
  description = "Desired number of tasks for the service"
  value       = aws_ecs_service.this.desired_count
}
