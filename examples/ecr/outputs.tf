output "repository_name" {
  description = "The name of the ECR repository"
  value       = module.lab-ecr.repository_name
}

output "repository_url" {
  description = "The URL of the ECR repository"
  value       = module.lab-ecr.repository_url
}

output "repository_arn" {
  description = "The ARN of the ECR repository"
  value       = module.lab-ecr.repository_arn
}

output "registry_id" {
  description = "The registry ID where the repository was created"
  value       = module.lab-ecr.registry_id
}

output "image_tag_mutability" {
  description = "The tag mutability setting for the repository"
  value       = module.lab-ecr.image_tag_mutability
}

output "scan_on_push_enabled" {
  description = "Whether images are scanned on push"
  value       = module.lab-ecr.scan_on_push_enabled
}

output "encryption_type" {
  description = "The encryption type used by the repository"
  value       = module.lab-ecr.encryption_type
}

# Convenience outputs for Docker workflow
output "docker_login_command" {
  description = "Command to login to ECR registry"
  value       = "aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${module.lab-ecr.repository_url}"
}

output "docker_build_commands" {
  description = "Example commands to build and push Docker image"
  value = [
    "docker build -t ${var.repository_name} .",
    "docker tag ${var.repository_name}:latest ${module.lab-ecr.repository_url}:latest",
    "docker push ${module.lab-ecr.repository_url}:latest"
  ]
}
