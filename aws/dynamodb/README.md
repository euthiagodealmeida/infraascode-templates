# DynamoDB Table Module

This module creates a simple, production-ready DynamoDB table, specifically optimized for OpenTofu/Terraform state locking and basic key-value storage.

## Features

- ✅ **OpenTofu/Terraform state locking ready** - Uses `LockID` as default primary key
- ✅ **Production-ready defaults** - Point-in-time recovery and encryption enabled
- ✅ **Cost-optimized** - Pay-per-request billing mode by default
- ✅ **Simple but flexible** - Supports both simple and composite primary keys
- ✅ **Secure by default** - Encryption and deletion protection enabled
- ✅ **Zero configuration** - Works with just a table name

## Usage

### Basic State Locking Table (Zero Configuration)

```hcl
module "terraform_state_lock" {
  source = "../dynamodb"
  
  table_name = "terraform-state-lock"
}
```

### Application Table with Composite Key

```hcl
module "user_sessions" {
  source = "../dynamodb"
  
  table_name = "user-sessions"
  hash_key   = "userId"
  range_key  = "sessionId"
  
  tags = {
    Environment = "production"
    Application = "my-app"
  }
}
```

### Provisioned Billing for Predictable Workloads

```hcl
module "app_table" {
  source = "../dynamodb"
  
  table_name     = "high-traffic-table"
  billing_mode   = "PROVISIONED"
  read_capacity  = 10
  write_capacity = 5
  
  # Disable deletion protection for dev environments
  deletion_protection_enabled = false
}
```

## Backend Configuration

After creating a state locking table, configure your InfraAsCode backend:

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "infrastructure/terraform.tfstate"
    region         = "sa-east-1"
    dynamodb_table = "terraform-state-lock"  # ← Output from this module
    encrypt        = true
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform/opentofu | >= 1.0 |
| aws | >= 5.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| table_name | The name of the DynamoDB table | `string` | n/a | yes |
| billing_mode | Controls billing mode (PROVISIONED or PAY_PER_REQUEST) | `string` | `"PAY_PER_REQUEST"` | no |
| hash_key | The attribute to use as the hash (partition) key | `string` | `"LockID"` | no |
| hash_key_type | The attribute type for the hash key (S, N, or B) | `string` | `"S"` | no |
| range_key | The attribute to use as the range (sort) key | `string` | `null` | no |
| range_key_type | The attribute type for the range key (S, N, or B) | `string` | `"S"` | no |
| read_capacity | The number of read units (only applies to PROVISIONED billing mode) | `number` | `5` | no |
| write_capacity | The number of write units (only applies to PROVISIONED billing mode) | `number` | `5` | no |
| enable_point_in_time_recovery | Enable point-in-time recovery for the table | `bool` | `true` | no |
| enable_encryption | Enable server-side encryption for the table | `bool` | `true` | no |
| deletion_protection_enabled | Enable deletion protection for the table | `bool` | `true` | no |
| tags | Tags to apply to the DynamoDB table | `map(string)` | `{"ManagedBy": "terraform"}` | no |

## Outputs

| Name | Description |
|------|-------------|
| table_name | The name of the DynamoDB table |
| table_id | The ID of the DynamoDB table |
| table_arn | The ARN of the DynamoDB table |
| hash_key | The hash (partition) key of the table |
| range_key | The range (sort) key of the table |
| billing_mode | The billing mode of the table |
| point_in_time_recovery_enabled | Whether point-in-time recovery is enabled |
| server_side_encryption_enabled | Whether server-side encryption is enabled |