variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "sa-east-1"
}

variable "family" {
  description = "Family name for the task definition"
  type        = string
}

variable "cpu" {
  description = "CPU units for the task (256, 512, 1024, 2048, 4096)"
  type        = number
  default     = 256
}

variable "memory" {
  description = "Memory in MB for the task (512, 1024, 2048, 4096, 8192)"
  type        = number
  default     = 512
}

variable "network_mode" {
  description = "Network mode for the task (awsvpc for Fargate)"
  type        = string
  default     = "awsvpc"
}

variable "requires_compatibilities" {
  description = "Launch types the task definition is compatible with"
  type        = list(string)
  default     = ["FARGATE"]
}

variable "container_definitions" {
  description = "Container definitions as JSON string"
  type        = string
}

variable "execution_role_arn" {
  description = "ARN of the task execution role"
  type        = string
}

variable "task_role_arn" {
  description = "ARN of the task role"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Environment = "lab"
    Project     = "lab-ecs-task-definition"
  }
}
