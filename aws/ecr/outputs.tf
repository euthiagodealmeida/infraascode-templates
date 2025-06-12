output "repository_name" {
  description = "The name of the ECR repository"
  value       = aws_ecr_repository.this.name
}

output "repository_url" {
  description = "The URL of the ECR repository"
  value       = aws_ecr_repository.this.repository_url
}

output "repository_arn" {
  description = "The ARN of the ECR repository"
  value       = aws_ecr_repository.this.arn
}

output "registry_id" {
  description = "The registry ID where the repository was created"
  value       = aws_ecr_repository.this.registry_id
}

output "image_tag_mutability" {
  description = "The tag mutability setting for the repository"
  value       = aws_ecr_repository.this.image_tag_mutability
}

output "scan_on_push_enabled" {
  description = "Whether images are scanned on push"
  value       = aws_ecr_repository.this.image_scanning_configuration[0].scan_on_push
}

output "encryption_type" {
  description = "The encryption type used by the repository"
  value       = aws_ecr_repository.this.encryption_configuration[0].encryption_type
}

output "repository_policy" {
  description = "The repository permissions policy if enabled"
  value       = var.enable_repository_policy ? aws_ecr_repository_policy.this[0].policy : null
}