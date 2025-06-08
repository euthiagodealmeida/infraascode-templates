# AWS S3 OpenTofu Module

A simple, configurable OpenTofu module for creating AWS S3 buckets with sensible defaults and optional features.

## Features

- ✅ **Secure by default**: Encryption enabled, public access blocked
- ✅ **Unique naming**: Automatic random suffix for bucket names
- ✅ **Configurable**: Easy to customize for different use cases
- ✅ **Website hosting**: Optional static website configuration
- ✅ **Public access**: Optional public read access with proper policies
- ✅ **Tagging**: Consistent resource tagging

## Usage

### Basic S3 Bucket

```hcl
module "s3_bucket" {
  source = "../aws/s3"

  name = "my-project-bucket"
  
  tags = {
    Environment = "production"
    Project     = "my-app"
  }
}
```

### S3 Bucket for Static Website

```hcl
module "website_bucket" {
  source = "../aws/s3"

  name               = "my-website"
  enable_public_read = true
  
  website_config = {
    index_document = "index.html"
    error_document = "error.html"
  }
  
  tags = {
    Environment = "production"
    Type        = "website"
  }
}
```

### S3 Bucket with KMS Encryption

```hcl
module "secure_bucket" {
  source = "../aws/s3"

  name               = "secure-data"
  versioning_enabled = true
  kms_key_id         = "arn:aws:kms:us-west-2:123456789012:key/12345678-1234-1234-1234-123456789012"
  
  tags = {
    Environment = "production"
    Security    = "high"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Base name for the S3 bucket | `string` | `"s3-bucket"` | no |
| bucket_name_override | Override bucket name completely | `string` | `null` | no |
| force_destroy | Allow deletion of non-empty bucket | `bool` | `false` | no |
| versioning_enabled | Enable versioning for the S3 bucket | `bool` | `false` | no |
| kms_key_id | AWS KMS key ID for encryption | `string` | `null` | no |
| bucket_key_enabled | Use S3 Bucket Key for SSE-KMS | `bool` | `true` | no |
| enable_public_read | Enable public read access | `bool` | `false` | no |
| website_config | Website configuration | `object({...})` | `null` | no |
| tags | Tags to apply to resources | `map(string)` | `{...}` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket_id | The name/ID of the bucket |
| bucket_arn | The ARN of the bucket |
| bucket_domain_name | The bucket domain name |
| bucket_regional_domain_name | The bucket region-specific domain name |
| bucket_website_endpoint | The website endpoint (if configured) |
| bucket_website_domain | The domain of the website endpoint (if configured) |

## Examples

For complete examples, see the `examples/` directory:

- [Basic S3 bucket](../examples/s3-basic/)
- [Static website](../examples/s3-website/)

## Requirements

| Name | Version |
|------|---------|
| opentofu | >= 1.6 |
| aws | >= 5.0 |
| random | >= 3.1 |
