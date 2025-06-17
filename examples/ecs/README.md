# ECS Cluster Example

This example demonstrates how to create a basic ECS cluster using the ECS module.

## What This Creates

- **ECS Cluster**: A Fargate-enabled cluster ready for containerized applications
- **Capacity Providers**: Configurable capacity providers (Fargate by default)
- **Optional Features**: Container Insights and ECS Exec support

## Usage

1. **Copy the example variables**:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. **Edit the variables** (optional):
   ```bash
   # terraform.tfvars
   cluster_name = "my-app-cluster"
   aws_region = "us-west-2"
   enable_container_insights = true
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

cluster_arn = "arn:aws:ecs:us-east-1:123456789012:cluster/my-ecs-cluster"
cluster_name = "my-ecs-cluster"
cluster_id = "my-ecs-cluster"
```

## Configuration Options

### Fargate (Default)
```hcl
capacity_providers = ["FARGATE"]
```

### Cost-Optimized with Spot
```hcl
capacity_providers = ["FARGATE", "FARGATE_SPOT"]
default_capacity_provider_strategy = [
  {
    capacity_provider = "FARGATE"
    weight           = 1
    base             = 1  # Always have 1 task on regular Fargate
  },
  {
    capacity_provider = "FARGATE_SPOT"
    weight           = 3  # Prefer spot for additional capacity
  }
]
```

### EC2 Instances
```hcl
capacity_providers = ["EC2"]
```

## What You Get

- ✅ **ECS Cluster**: Ready for task/service deployment
- ✅ **Fargate Support**: Serverless container execution
- ✅ **Flexible Capacity**: Easy switch between Fargate and EC2
- ✅ **Monitoring Ready**: Optional Container Insights
- ✅ **Debug Ready**: Optional ECS Exec support

Perfect foundation for containerized applications! 🐳
