# ECS Service Module

This module creates an AWS ECS Service that manages and maintains a desired number of tasks from an ECS task definition. The service handles deployment, health checks, load balancer integration, and ensures your containers stay running.

## Features

- **Task Management**: Maintains desired count of running tasks
- **Load Balancer Integration**: Automatic registration/deregistration with ALB/NLB
- **Rolling Deployments**: Safe deployment with configurable health thresholds
- **Network Configuration**: Support for Fargate and EC2 launch types
- **Health Checks**: Configurable grace periods for new tasks
- **ECS Exec Support**: Optional debugging access to running containers
- **Service Discovery**: Optional integration with AWS Cloud Map
- **Platform Versioning**: Automatic latest Fargate platform features
- **Tag Propagation**: Propagate tags from service to tasks
- **Force Deployment**: Capability to force new deployments when needed
- **Auto Scaling Ready**: Compatible with ECS Auto Scaling (external configuration)

## Usage

### Basic Fargate Service

```hcl
module "ecs_service" {
  source = "./aws/ecs_service"

  service_name        = "lab-ecs-service"
  cluster_id          = "my-ecs-cluster"
  task_definition_arn = "arn:aws:ecs:us-west-2:123456789012:task-definition/my-app:1"
  desired_count       = 2

  # Network configuration for Fargate
  subnet_ids         = ["subnet-12345678", "subnet-87654321"]
  security_group_ids = ["sg-12345678"]
  assign_public_ip   = false

  tags = {
    Environment = "lab"
    Project     = "lab-ecs-service"
  }
}
```

### Service with Load Balancer

```hcl
module "ecs_service" {
  source = "./aws/ecs_service"

  service_name        = "lab-ecs-service"
  cluster_id          = module.ecs_cluster.cluster_id
  task_definition_arn = module.task_definition.task_definition_arn
  desired_count       = 3

  # Network configuration
  subnet_ids         = ["subnet-12345678", "subnet-87654321"]
  security_group_ids = [module.security_group.security_group_id]

  # Load balancer integration
  load_balancer_config = {
    target_group_arn = module.alb.target_group_arn
    container_name   = "web"
    container_port   = 80
  }

  # Health check configuration
  health_check_grace_period_seconds = 120

  # Enable debugging
  enable_execute_command = true

  tags = {
    Environment = "lab"
    Project     = "lab-ecs-service"
  }
}
```

### EC2 Launch Type

```hcl
module "ecs_service" {
  source = "./aws/ecs_service"

  service_name        = "lab-ecs-service"
  cluster_id          = module.ecs_cluster.cluster_id
  task_definition_arn = module.task_definition.task_definition_arn
  desired_count       = 5
  launch_type         = "EC2"

  # No network configuration needed for EC2

  tags = {
    Environment = "lab"
    Type        = "lab-ecs-service-worker"
  }
}
```

### Service with Service Discovery

```hcl
module "ecs_service" {
  source = "./aws/ecs_service"

  service_name        = "lab-ecs-service"
  cluster_id          = module.ecs_cluster.cluster_id
  task_definition_arn = module.task_definition.task_definition_arn
  desired_count       = 2

  # Network configuration
  subnet_ids         = ["subnet-12345678", "subnet-87654321"]
  security_group_ids = [module.security_group.security_group_id]

  # Service discovery integration
  service_registry_arn = module.service_discovery.service_arn

  # Platform and tagging configuration
  platform_version = "1.4.0"  # Specific platform version
  propagate_tags   = "SERVICE" # Propagate service tags to tasks

  tags = {
    Environment = "lab"
    Project     = "lab-ecs-service"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| service_name | Name of the ECS service | `string` | n/a | yes |
| cluster_id | ID or ARN of the ECS cluster | `string` | n/a | yes |
| task_definition_arn | ARN of the task definition to run in the service | `string` | n/a | yes |
| desired_count | Number of instances of the task definition to place and keep running | `number` | `1` | no |
| launch_type | Launch type on which to run your service. Valid values are EC2, FARGATE, and EXTERNAL | `string` | `"FARGATE"` | no |
| platform_version | Platform version on which to run your service (only applicable for Fargate) | `string` | `"LATEST"` | no |
| force_new_deployment | Force a new deployment of the service when applying changes | `bool` | `false` | no |
| propagate_tags | Specifies whether to propagate the tags from the task definition or service to the tasks. Valid values are NONE, TASK_DEFINITION, SERVICE | `string` | `"NONE"` | no |
| subnet_ids | Subnets associated with the task or service (required for Fargate) | `list(string)` | `[]` | no |
| security_group_ids | Security groups associated with the task or service | `list(string)` | `[]` | no |
| assign_public_ip | Assign a public IP address to the ENI (Fargate launch type only) | `bool` | `false` | no |
| load_balancer_config | Load balancer configuration for the service | `object({target_group_arn=string, container_name=string, container_port=number})` | `null` | no |
| service_registry_arn | ARN of the service registry for service discovery (optional) | `string` | `null` | no |
| deployment_maximum_percent | Upper limit (as a percentage of the service's desiredCount) of the number of running tasks | `number` | `200` | no |
| deployment_minimum_healthy_percent | Lower limit (as a percentage of the service's desiredCount) of the number of running tasks | `number` | `100` | no |
| enable_execute_command | Enable ECS Exec for debugging | `bool` | `false` | no |
| health_check_grace_period_seconds | Seconds to ignore failing load balancer health checks on newly instantiated tasks | `number` | `60` | no |
| wait_for_steady_state | Wait for the service to reach a steady state before continuing | `bool` | `false` | no |
| tags | Tags to apply to the ECS service | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| service_arn | ARN of the ECS service |
| service_name | Name of the ECS service |
| service_cluster | Cluster name where the service is running |
| service_task_definition | Task definition ARN used by the service |
| service_desired_count | Desired number of tasks for the service |

## Notes

### Launch Types
- **Fargate**: Requires `subnet_ids` and `security_group_ids`. Optionally set `assign_public_ip`
- **EC2**: Uses the cluster's EC2 instances. Network configuration is handled at the instance level
- **EXTERNAL**: For services running on external compute (AWS Fargate on Outposts, etc.)

### Load Balancer Integration
- When using a load balancer, set `health_check_grace_period_seconds` appropriately
- The container specified in `load_balancer_config.container_name` must exist in your task definition
- Container port should match the port exposed in your container definition

### Deployment Strategy
- `deployment_maximum_percent` controls how many extra tasks can run during deployment
- `deployment_minimum_healthy_percent` controls the minimum number of healthy tasks during deployment
- For zero-downtime deployments, keep `deployment_minimum_healthy_percent` at 100%

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.8.0 |
| aws | >= 5.0.0 |
