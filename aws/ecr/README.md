# AWS ECR Module

A simple, configurable ECR (Elastic Container Registry) module designed as a reusable "Lego piece" for AWS container infrastructure.

## ✨ Features

- 🐳 **Container registry ready** - Store and manage Docker images
- 🔍 **Vulnerability scanning** - Scan images on push by default  
- 🔐 **Secure by default** - AES256 encryption enabled
- 🏷️ **Flexible tagging** - Mutable or immutable tag support
- ♻️ **Lifecycle management** - Automatic cleanup of old images
- 🧹 **Cost optimization** - Configurable image retention policies
- 🔑 **KMS encryption support** - Optional KMS key encryption

## 🚀 Usage

### Basic Container Registry (Zero Configuration)

```hcl
module "api_registry" {
  source = "../../aws/ecr"
  
  repository_name = "go-hello-api"
}
```

### Production Registry with Immutable Tags

```hcl
module "prod_registry" {
  source = "../../aws/ecr"
  
  repository_name      = "go-hello-api"
  image_tag_mutability = "IMMUTABLE"
  scan_on_push         = true
  
  tags = {
    Environment = "production"
    Project     = "go-api"
  }
}
```

### Development Registry with Aggressive Cleanup

```hcl
module "dev_registry" {
  source = "../../aws/ecr"
  
  repository_name     = "go-hello-api-dev"
  force_delete        = true
  max_image_count     = 5
  untagged_image_days = 1
  
  tags = {
    Environment = "development"
    Project     = "go-api"
  }
}
```

### Registry with KMS Encryption

```hcl
module "secure_registry" {
  source = "../../aws/ecr"
  
  repository_name = "go-hello-api"
  encryption_type = "KMS"
  kms_key_id      = "alias/ecr-encryption-key"
  
  tags = {
    Environment = "production"
    Compliance  = "required"
  }
}
```

## Docker Workflow

After creating the registry, use these commands to build and push:

```bash
# Get login token
aws ecr get-login-password --region sa-east-1 | \
  docker login --username AWS --password-stdin <registry_url>

# Build and tag
docker build -t go-hello-api .
docker tag go-hello-api:latest <registry_url>/go-hello-api:latest

# Push to ECR
docker push <registry_url>/go-hello-api:latest
```

## Requirements

| Name | Version |
|------|---------|
| terraform/opentofu | >= 1.0 |
| aws | >= 5.0 |

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
| max_image_count | Maximum number of tagged images to keep | `number` | `10` | no |
| untagged_image_days | Days to keep untagged images | `number` | `1` | no |
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

## 🔄 Lifecycle Policy

The module automatically creates a lifecycle policy that:

1. **Keeps the last 10 tagged images** (configurable via `max_image_count`)
2. **Deletes untagged images after 1 day** (configurable via `untagged_image_days`)

This helps manage storage costs while ensuring you always have recent images available.

## 🏷️ Tag Strategy Recommendations

### For Production:
- Use `IMMUTABLE` tags to prevent accidental overwrites
- Tag with semantic versions: `v1.0.0`, `v1.0.1`
- Keep more images: `max_image_count = 20`

### For Development:
- Use `MUTABLE` tags for flexibility  
- Tag with branch names: `main`, `feature-branch`
- Aggressive cleanup: `max_image_count = 5`

## 🔐 Security Best Practices

- ✅ Vulnerability scanning enabled by default
- ✅ Encryption at rest with AES256
- ✅ Optional KMS encryption for compliance
- ✅ Lifecycle policies prevent storage bloat
- ✅ IAM policies control access (not managed by this module)
