# IAM Role Example

This example demonstrates how to create a basic IAM role with policy attachments using the IAM role module.

## What This Creates

- **IAM Role**: An ECS task role that can be assumed by ECS tasks
- **AWS Managed Policy**: Attaches `AmazonECSTaskExecutionRolePolicy` for basic ECS functionality
- **Inline Policy**: Adds custom CloudWatch logs permissions

## Usage

1. **Copy the example variables**:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. **Edit the variables** (optional):
   ```bash
   # terraform.tfvars
   role_name = "my-app-ecs-role"
   aws_region = "us-west-2"
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

role_arn = "arn:aws:iam::123456789012:role/my-ecs-task-role"
role_name = "my-ecs-task-role"
role_id = "AROABC123DEFGHIJKLMN"
```

## What You Get

- ✅ **IAM Role**: Ready to be used by ECS tasks
- ✅ **ECS Permissions**: Can pull images, write logs, etc.
- ✅ **CloudWatch Logs**: Custom permissions for application logging
- ✅ **Tags**: Properly tagged for organization

Perfect foundation for ECS-based applications! 🚀
