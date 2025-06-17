# AWS IAM Role Module

A simple, composable Terraform module for creating AWS IAM roles following the "Lego piece" philosophy.

## Features

- ✅ **Simple IAM Role Creation** - Create roles with custom assume role policies
- ✅ **Policy Attachments** - Support for AWS managed, customer managed, and inline policies
- ✅ **Minimal Configuration** - Only requires role name and assume role policy
- ✅ **Composable Design** - Works as a building block with other modules

## Usage

### Basic Usage

```hcl
module "ecs_task_role" {
  source = "../../aws/iam_role"

  name        = "ecs-task-role"
  description = "IAM role for Go API ECS tasks"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  # AWS managed policies
  aws_managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  ]

  # Custom inline policy for your application
  inline_policies = {
    app_permissions = {
      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "logs:CreateLogGroup",
              "logs:CreateLogStream",
              "logs:PutLogEvents"
            ]
            Resource = "arn:aws:logs:*:*:*"
          }
        ]
      })
    }
  }

  tags = {
    Environment = "production"
    Application = "go-api"
  }
}

```

## Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `name` | Name of the IAM role | `string` | Required |
| `description` | Description of the IAM role | `string` | `"IAM role managed by OpenTofu"` |
| `assume_role_policy` | IAM assume role policy document (JSON string) | `string` | Required |
| `aws_managed_policy_arns` | List of AWS managed policy ARNs to attach | `list(string)` | `[]` |
| `customer_managed_policy_arns` | List of customer managed policy ARNs to attach | `list(string)` | `[]` |
| `inline_policies` | Map of inline policies to attach | `map(object)` | `{}` |
| `max_session_duration` | Maximum session duration (seconds) | `number` | `3600` |
| `path` | Path to the role | `string` | `"/"` |
| `permissions_boundary` | ARN of permissions boundary policy | `string` | `null` |
| `force_detach_policies` | Force detach policies when destroying | `bool` | `false` |
| `tags` | Tags to apply to the role | `map(string)` | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| `role_arn` | ARN of the IAM role |
| `role_name` | Name of the IAM role |
| `role_id` | ID of the IAM role |
| `role_unique_id` | Unique ID of the IAM role |

## Requirements

| Name | Version |
|------|---------|
| terraform/opentofu | >= 1.0 |
| aws | >= 5.0 |
