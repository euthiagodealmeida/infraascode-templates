output "bucket_id" {
  description = "The name/ID of the S3 bucket"
  value       = module.lab-s3.bucket_id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = module.lab-s3.bucket_arn
}

output "bucket_domain_name" {
  description = "The bucket domain name"
  value       = module.lab-s3.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "The bucket region-specific domain name"
  value       = module.lab-s3.bucket_regional_domain_name
}

output "bucket_hosted_zone_id" {
  description = "The Route 53 Hosted Zone ID for this bucket's region"
  value       = module.lab-s3.bucket_hosted_zone_id
}

output "bucket_region" {
  description = "The AWS region this bucket resides in"
  value       = module.lab-s3.bucket_region
}

output "bucket_website_endpoint" {
  description = "The website endpoint, if the bucket is configured with a website"
  value       = module.lab-s3.bucket_website_endpoint
}

output "bucket_website_domain" {
  description = "The domain of the website endpoint, if the bucket is configured with a website"
  value       = module.lab-s3.bucket_website_domain
}

output "bucket_versioning_enabled" {
  description = "Whether versioning is enabled on the bucket"
  value       = module.lab-s3.bucket_versioning_enabled
}

output "bucket_public_read_enabled" {
  description = "Whether public read access is enabled"
  value       = module.lab-s3.bucket_public_read_enabled
}

output "bucket_website_enabled" {
  description = "Whether website configuration is enabled"
  value       = module.lab-s3.bucket_website_enabled
}

output "bucket_kms_encrypted" {
  description = "Whether the bucket uses KMS encryption"
  value       = module.lab-s3.bucket_kms_encrypted
}

output "bucket_summary" {
  description = "Summary of the created S3 bucket"
  value = {
    name              = var.bucket_name
    region            = var.aws_region
    versioning        = var.enable_versioning
    public_read       = var.enable_public_read
    website_enabled   = var.website_config != null
    kms_encrypted     = var.kms_key_id != null
  }
}
