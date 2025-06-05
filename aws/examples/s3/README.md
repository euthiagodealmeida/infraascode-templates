# S3 Basic Bucket Example

This example demonstrates how to create a simple S3 bucket using the S3 module with basic configuration.

## Features

- **Secure by Default**: Public access blocked, versioning enabled, AES256 encryption
- **Simple Configuration**: Basic S3 bucket with minimal required settings
- **Customizable**: Easy to modify bucket name, tags, and basic settings

## Usage

1. **Copy the example configuration:**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. **Edit the configuration:**
   ```bash
   # Update bucket_name to be globally unique
   bucket_name = "your-unique-bucket-name-2025"
   
   # Customize other settings as needed
   versioning_status = "Enabled"
   ```

3. **Initialize and apply:**
   ```bash
   tofu init
   tofu plan
   tofu apply
   ```

## Important Notes

- **Bucket names must be globally unique** across all of AWS
- **Change the bucket_name** in terraform.tfvars before applying
- **Secure by default**: Public access is blocked, versioning enabled
- **No files included**: This example only creates the bucket structure

## What's Created

- S3 bucket with AES256 encryption
- Versioning enabled
- Public access blocked (secure)
- Basic tags applied

## Customization

You can customize:
- Bucket name (required - must be unique)
- Versioning status (Enabled/Suspended)
- Encryption settings (AES256 or KMS)
- Tags for resource organization

## Cleanup

```bash
tofu destroy
```

**Note**: If `force_destroy = false` (default), ensure the bucket is empty before destroying.
