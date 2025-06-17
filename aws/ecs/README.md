# AWS ECS Module

A simple, composable Terraform module for creating AWS ECS clusters following the "Lego piece" philosophy.

## Features

- **ECS Cluster Creation** - Simple cluster with configurable capacity providers
- **Fargate Support** - Fargate-ready by default with easy toggle
- **EC2 Support** - Can switch to EC2 capacity providers
- **Container Insights** - Optional CloudWatch monitoring
- **ECS Exec** - Optional debugging capabilities
- **Composable Design** - Works as a building block with other modules

## Usage

### Basic Fargate Cluster

```hcl
module "ecs_cluster" {
  source = "../../aws/ecs"

  cluster_name = "my-app-cluster"

  # Fargate by default - no additional configuration needed
  tags = {
    Environment = "production"
    Application = "my-app"
  }
}
```

### Mixed Fargate/Spot Cluster

```hcl
module "ecs_cluster" {
  source = "../../aws/ecs"

  cluster_name = "cost-optimized-cluster"

  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy = [
    {
      capacity_provider = "FARGATE"
      weight           = 1
      base             = 2  # Always have 2 tasks on regular Fargate
    },
    {
      capacity_provider = "FARGATE_SPOT"
      weight           = 4  # Prefer spot for additional capacity
    }
  ]

  enable_container_insights = true
  enable_execute_command    = true
}
```

### EC2 Cluster

```hcl
module "ecs_cluster" {
  source = "../../aws/ecs"

  cluster_name = "ec2-cluster"

  capacity_providers = ["EC2"]

  default_capacity_provider_strategy = [
    {
      capacity_provider = "EC2"
      weight           = 1
    }
  ]
}
```

## Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `cluster_name` | Name of the ECS cluster | `string` | Required |
| `capacity_providers` | List of capacity providers | `list(string)` | `["FARGATE"]` |
| `default_capacity_provider_strategy` | Default capacity provider strategy | `list(object)` | Fargate strategy |
| `enable_container_insights` | Enable CloudWatch Container Insights | `bool` | `false` |
| `enable_execute_command` | Enable ECS Exec for debugging | `bool` | `false` |
| `tags` | Tags to apply to the cluster | `map(string)` | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| `cluster_arn` | ARN of the ECS cluster |
| `cluster_name` | Name of the ECS cluster |
| `cluster_id` | ID of the ECS cluster |

## Requirements

| Name | Version |
|------|---------|
| terraform/opentofu | >= 1.0 |
| aws | >= 5.0 |
