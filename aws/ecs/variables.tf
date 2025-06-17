variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "capacity_providers" {
  description = "List of capacity providers for the cluster"
  type        = list(string)
  default     = ["FARGATE"]
}

variable "default_capacity_provider_strategy" {
  description = "Default capacity provider strategy for the cluster"
  type = list(object({
    capacity_provider = string
    weight           = number
    base             = optional(number)
  }))
  default = [
    {
      capacity_provider = "FARGATE"
      weight           = 1
    }
  ]
}

variable "enable_container_insights" {
  description = "Enable CloudWatch Container Insights for the cluster"
  type        = bool
  default     = false
}

variable "enable_execute_command" {
  description = "Enable ECS Exec for debugging"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to the ECS cluster"
  type        = map(string)
  default     = {}
}
