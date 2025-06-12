# AWS ECR Module

A simple, configurable ECR (Elastic Container Registry) module designed as a reusable "Lego piece" for AWS container infrastructure.

## ✨ Features

- 🐳 **Container registry ready** - Store and manage Docker images
- 🔍 **Vulnerability scanning** - Scan images on push by default  
- 🔐 **Secure by default** - AES256 encryption enabled
- 🏷️ **Flexible tagging** - Mutable or immutable tag support
- ♻️ **Lifecycle management** - TODO
- 🔑 **KMS encryption support** - Optional KMS key encryption
- 🛡️ **Access control** - Repository-level permissions

## 🚀 Usage

### Basic Container Registry (Zero Configuration)

```hcl
module "api_registry" {
  source = "../../aws/ecr"
  
  repository_name = "my-repository-name"
}
```

### Production Registry with Immutable Tags

```hcl
module "prod_registry" {
  source = "../../aws/ecr"
  
  repository_name      = "my-repository-name"
  image_tag_mutability = "IMMUTABLE"
  scan_on_push         = true
  
  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

### Development Registry with Aggressive Cleanup

```hcl
module "dev_registry" {
  source = "../../aws/ecr"
  
  repository_name     = "my-repository-name"
  force_delete        = true
  
  tags = {
    Environment = "development"
    Project     = "my-project"
  }
}
```

### Registry with CI/CD Permissions

```hcl
module "cicd_registry" {
  source = "../../aws/ecr"
  
  repository_name           = "my-repository-name"
  enable_repository_policy  = true
  allowed_principals = [
    "arn:aws:iam::123456789012:role/role-1",
    "arn:aws:iam::123456789012:role/role-2"
  ]
  
  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

### Registry with KMS Encryption

```hcl
module "secure_registry" {
  source = "../../aws/ecr"
  
  repository_name = "my-repository-name"
  encryption_type = "KMS"
  kms_key_id      = "alias/ecr-encryption-key"
  
  tags = {
    Environment = "production"
    Compliance  = "required"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| repository_name | The name of the ECR repository | `string` | n/a | yes |
| image_tag_mutability | The tag mutability setting (MUTABLE or IMMUTABLE) | `string` | `"MUTABLE"` | no |
| force_delete | If true, delete repository even if it contains images | `bool` | `false` | no |
| scan_on_push | Scan images after being pushed to repository | `bool` | `true` | no |
| encryption_type | The encryption type (AES256 or KMS) | `string` | `"AES256"` | no |
| kms_key_id | KMS key ID for encryption (when encryption_type is KMS) | `string` | `null` | no |
| enable_lifecycle_policy | Enable lifecycle policy for image cleanup | `bool` | `true` | no |
| enable_repository_policy | Enable repository permissions for cross-account or service access | `bool` | `false` | no |
| repository_policy | Custom repository permission policy JSON | `string` | `null` | no |
| allowed_principals | List of AWS principals allowed to access the repository | `list(string)` | `[]` | no |
| tags | Tags to apply to the ECR repository | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| repository_name | The name of the ECR repository |
| repository_url | The URL of the ECR repository |
| repository_arn | The ARN of the ECR repository |
| registry_id | The registry ID where the repository was created |
| image_tag_mutability | The tag mutability setting for the repository |
| scan_on_push_enabled | Whether images are scanned on push |
| encryption_type | The encryption type used by the repository |
| repository_policy | The repository permissions policy if enabled |

## Requirements

| Name | Version |
|------|---------|
| terraform/opentofu | >= 1.0 |
| aws | >= 5.0 |