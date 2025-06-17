# ECS Task Definition Example

This example demonstrates how to create a basic ECS task definition using the ECS Task Definition module.

## What This Creates

- **ECS Task Definition**: A container blueprint for running applications
- **Container Specification**: Defines image, resources, and configuration
- **Fargate Compatible**: Ready for serverless container execution

## Usage

1. **Copy the example variables**:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. **Edit the variables** (required - update IAM role ARNs):
   ```bash
   # terraform.tfvars
   family = "my-app-task"
   execution_role_arn = "arn:aws:iam::YOUR-ACCOUNT:role/ecsTaskExecutionRole"
   task_role_arn = "arn:aws:iam::YOUR-ACCOUNT:role/ecsTaskRole"
   ```

3. **Initialize and apply**:
   ```bash
   tofu init
   tofu plan
   tofu apply
   ```

## Example Output

```bash
Outputs:

task_definition_arn = "arn:aws:ecs:us-east-1:123456789012:task-definition/my-app-task:1"
task_definition_family = "my-app-task"
task_definition_revision = "1"
task_definition_arn_without_revision = "arn:aws:ecs:us-east-1:123456789012:task-definition/my-app-task"
```

## Container Definition Examples

### Simple Web Server
```json
{
  "name": "nginx",
  "image": "nginx:latest",
  "portMappings": [
    {
      "containerPort": 80,
      "protocol": "tcp"
    }
  ],
  "essential": true
}
```

### Go API Application
```json
{
  "name": "go-api",
  "image": "my-ecr/go-api:latest",
  "portMappings": [
    {
      "containerPort": 8080,
      "protocol": "tcp"
    }
  ],
  "environment": [
    {
      "name": "PORT",
      "value": "8080"
    }
  ],
  "logConfiguration": {
    "logDriver": "awslogs",
    "options": {
      "awslogs-group": "/ecs/go-api",
      "awslogs-region": "us-east-1",
      "awslogs-stream-prefix": "ecs"
    }
  },
  "essential": true
}
```

## Prerequisites

### IAM Roles Required

1. **Task Execution Role** (for ECS to manage containers):
   ```bash
   # AWS managed policy: AmazonECSTaskExecutionRolePolicy
   ```

2. **Task Role** (for your application):
   ```bash
   # Custom policies based on your app needs
   ```

## Resource Combinations (Fargate)

| CPU (vCPU) | Memory (MB) |
|------------|-------------|
| 256 (0.25) | 512, 1024, 2048 |
| 512 (0.5)  | 1024, 2048, 3072, 4096 |
| 1024 (1)   | 2048, 3072, 4096, 5120, 6144, 7168, 8192 |

## What You Get

- ✅ **Task Definition**: Container blueprint ready for deployment
- ✅ **Fargate Compatible**: Serverless container execution
- ✅ **CloudWatch Logging**: Application logs in CloudWatch
- ✅ **Resource Optimized**: Appropriate CPU and memory allocation
- ✅ **Production Ready**: With health checks and proper configuration

Perfect foundation for containerized applications! 🐳
