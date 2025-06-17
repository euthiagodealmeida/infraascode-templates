output "cluster_arn" {
  description = "ARN of the created ECS cluster"
  value       = module.ecs_cluster.cluster_arn
}

output "cluster_name" {
  description = "Name of the created ECS cluster"
  value       = module.ecs_cluster.cluster_name
}

output "cluster_id" {
  description = "ID of the created ECS cluster"
  value       = module.ecs_cluster.cluster_id
}
