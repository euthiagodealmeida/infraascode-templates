variable "service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "cluster_id" {
  description = "ID or ARN of the ECS cluster"
  type        = string
}

variable "task_definition_arn" {
  description = "ARN of the task definition to run in the service"
  type        = string
}

variable "desired_count" {
  description = "Number of instances of the task definition to place and keep running"
  type        = number
  default     = 1
}

variable "launch_type" {
  description = "Launch type on which to run your service. Valid values are EC2, FARGATE, and EXTERNAL"
  type        = string
  default     = "FARGATE"

  validation {
    condition     = contains(["EC2", "FARGATE", "EXTERNAL"], var.launch_type)
    error_message = "Launch type must be one of: EC2, FARGATE, EXTERNAL."
  }
}

variable "platform_version" {
  description = "Platform version on which to run your service (only applicable for Fargate)"
  type        = string
  default     = "LATEST"
}

variable "force_new_deployment" {
  description = "Force a new deployment of the service when applying changes"
  type        = bool
  default     = false
}

variable "propagate_tags" {
  description = "Specifies whether to propagate the tags from the task definition or service to the tasks"
  type        = string
  default     = "NONE"

  validation {
    condition     = contains(["NONE", "TASK_DEFINITION", "SERVICE"], var.propagate_tags)
    error_message = "Propagate tags must be one of: NONE, TASK_DEFINITION, SERVICE."
  }
}

variable "subnet_ids" {
  description = "Subnets associated with the task or service"
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "Security groups associated with the task or service"
  type        = list(string)
  default     = []
}

variable "assign_public_ip" {
  description = "Assign a public IP address to the ENI (Fargate launch type only)"
  type        = bool
  default     = false
}

variable "load_balancer_config" {
  description = "Load balancer configuration for the service"
  type = object({
    target_group_arn = string
    container_name   = string
    container_port   = number
  })
  default = null
}

variable "service_registry_arn" {
  description = "ARN of the service registry for service discovery (optional)"
  type        = string
  default     = null
}

variable "deployment_maximum_percent" {
  description = "Upper limit (as a percentage of the service's desiredCount) of the number of running tasks"
  type        = number
  default     = 200
}

variable "deployment_minimum_healthy_percent" {
  description = "Lower limit (as a percentage of the service's desiredCount) of the number of running tasks"
  type        = number
  default     = 100
}

variable "health_check_grace_period_seconds" {
  description = "Seconds to ignore failing load balancer health checks on newly instantiated tasks"
  type        = number
  default     = 60
}

variable "enable_execute_command" {
  description = "Enable ECS Exec for debugging"
  type        = bool
  default     = false
}

variable "wait_for_steady_state" {
  description = "Wait for the service to reach a steady state before continuing"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the ECS service"
  type        = map(string)
  default     = {}
}
