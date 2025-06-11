# AWS S3 Module

A simple, configurable S3 bucket module designed as a reusable "Lego piece" for AWS infrastructure.

## ✨ Features

- 🔐 **Secure by default** - AES256 encryption enabled, public access blocked
- 📦 **Optional versioning** - Enable/disable bucket versioning with boolean flag
- 🔑 **KMS encryption support** - Optional KMS key encryption
- 🌍 **Public read access** - Optional public bucket configuration
- 🌐 **Static website hosting** - Optional website configuration with object
- 🏷️ **Consistent tagging** - Merge custom tags with defaults

## 🚀 Usage

### Basic Private Bucket
```hcl
module "private_bucket" {
  source = "../s3"
  
  bucket_name = "my-private-bucket-2025"
  
  tags = {
    Environment = "production"
    Project     = "my-app"
  }
}
```

### Versioned Bucket with KMS
```hcl
module "versioned_bucket" {
  source = "../s3"
  
  bucket_name       = "my-versioned-bucket-2025"
  enable_versioning = true
  kms_key_id        = "arn:aws:kms:region:account:key/key-id"
  
  tags = {
    Environment = "production"
    Project     = "my-app"
  }
}
```

### Public Website Bucket
```hcl
module "website_bucket" {
  source = "../s3"
  
  bucket_name        = "my-website-bucket-2025"
  enable_public_read = true
  
  website_config = {
    index_document = "index.html"
    error_document = "error.html"
  }
  
  tags = {
    Environment = "production"
    Project     = "my-website"
  }
}
```

## 📋 Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| bucket_name | The name of the S3 bucket | `string` | - | yes |
| force_destroy | Allow deletion of non-empty bucket | `bool` | `false` | no |
| enable_versioning | Enable versioning on the S3 bucket | `bool` | `false` | no |
| kms_key_id | The AWS KMS key ID for encryption | `string` | `null` | no |
| bucket_key_enabled | Whether to use S3 Bucket Key for SSE-KMS | `bool` | `true` | no |
| enable_public_read | Enable public read access to the bucket | `bool` | `false` | no |
| website_config | Website configuration object | `object({...})` | `null` | no |
| tags | Tags to apply to the S3 bucket | `map(string)` | `{ManagedBy="terraform"}` | no |

## 📤 Outputs

| Name | Description |
|------|-------------|
| bucket_id | The ID of the bucket |
| bucket_arn | The ARN of the bucket |
| bucket_domain_name | The bucket domain name |
| bucket_regional_domain_name | The bucket region-specific domain name |
| bucket_website_endpoint | The website endpoint (if configured) |
| bucket_website_domain | The domain of the website endpoint (if configured) |
| bucket_versioning_enabled | Whether versioning is enabled |
| bucket_public_read_enabled | Whether public read access is enabled |
| bucket_website_enabled | Whether website configuration is enabled |
| bucket_kms_encrypted | Whether the bucket uses KMS encryption |

## 🔒 Security

- **Encryption enabled by default** using AES256
- **Public access blocked by default** 
- **Versioning optional** for data protection
- **KMS encryption support** for enhanced security
- **Explicit public access** - must be explicitly enabled

## 📝 Requirements

| Name | Version |
|------|---------|
| terraform/opentofu | >= 1.0 |
| aws | ~> 5.0 |
