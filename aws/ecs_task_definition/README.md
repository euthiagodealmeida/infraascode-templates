# AWS ECS Task Definition Module

A simple, composable Terraform module for creating AWS ECS task definitions following the "Lego piece" philosophy.

## Features

- **Container Specifications** - Define containers, resources, and configuration
- **Fargate Ready** - Optimized for serverless containers
- **Flexible Volumes** - Support for EFS, Docker volumes, and host paths
- **IAM Integration** - Task execution and application roles
- **Resource Control** - CPU and memory allocation
- **Composable Design** - Works as a building block with other modules

## Usage

### Basic Web Application

```hcl
module "web_app_task" {
  source = "../../aws/ecs_task_definition"

  family = "web-app"
  cpu    = 512
  memory = 1024

  execution_role_arn = module.execution_role.role_arn
  task_role_arn     = module.task_role.role_arn

  container_definitions = jsonencode([
    {
      name  = "web"
      image = "nginx:latest"
      
      portMappings = [
        {
          containerPort = 80
          protocol      = "tcp"
        }
      ]
      
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/web-app"
          "awslogs-region"        = "sa-east-1"
          "awslogs-stream-prefix" = "ecs"
        }
      }
      
      essential = true
    }
  ])

  tags = {
    Environment = "production"
    Application = "web-app"
  }
}
```

### Multi-Container Application

```hcl
module "api_with_sidecar" {
  source = "../../aws/ecs_task_definition"

  family = "api-with-sidecar"
  cpu    = 1024
  memory = 2048

  execution_role_arn = module.execution_role.role_arn
  task_role_arn     = module.task_role.role_arn

  container_definitions = jsonencode([
    {
      name  = "api"
      image = "myapp/api:latest"
      
      portMappings = [
        {
          containerPort = 8080
          protocol      = "tcp"
        }
      ]
      
      environment = [
        {
          name  = "DATABASE_URL"
          value = "postgresql://..."
        }
      ]
      
      essential = true
    },
    {
      name  = "nginx-proxy"
      image = "nginx:alpine"
      
      portMappings = [
        {
          containerPort = 80
          protocol      = "tcp"
        }
      ]
      
      dependsOn = [
        {
          containerName = "api"
          condition     = "START"
        }
      ]
      
      essential = true
    }
  ])
}
```

### Application with EFS Volume

```hcl
# TODO: Volume support not yet implemented
# module "app_with_storage" {
#   source = "../../aws/ecs_task_definition"
# }
```

## Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `family` | Family name for the task definition | `string` | Required |
| `cpu` | CPU units for the task | `number` | `256` |
| `memory` | Memory in MB for the task | `number` | `512` |
| `container_definitions` | Container definitions as JSON string | `string` | Required |
| `execution_role_arn` | ARN of the task execution role | `string` | Required |
| `task_role_arn` | ARN of the task role | `string` | `null` |
| `network_mode` | Network mode for the task | `string` | `"awsvpc"` |
| `requires_compatibilities` | Launch types supported | `list(string)` | `["FARGATE"]` |
| `tags` | Tags to apply to the task definition | `map(string)` | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| `task_definition_arn` | ARN of the task definition |
| `task_definition_family` | Family of the task definition |
| `task_definition_revision` | Revision number of the task definition |
| `task_definition_arn_without_revision` | ARN without revision number |

## Requirements

| Name | Version |
|------|---------|
| terraform/opentofu | >= 1.0 |
| aws | >= 5.0 |
