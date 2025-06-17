output "task_definition_arn" {
  description = "ARN of the created task definition"
  value       = module.app_task_definition.task_definition_arn
}

output "task_definition_family" {
  description = "Family of the created task definition"
  value       = module.app_task_definition.task_definition_family
}

output "task_definition_revision" {
  description = "Revision number of the created task definition"
  value       = module.app_task_definition.task_definition_revision
}

output "task_definition_arn_without_revision" {
  description = "ARN of the task definition without revision number"
  value       = module.app_task_definition.task_definition_arn_without_revision
}
