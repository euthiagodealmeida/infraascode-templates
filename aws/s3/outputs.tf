output "bucket_id" {
  description = "The ID of the bucket"
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "The ARN of the bucket"
  value       = aws_s3_bucket.this.arn
}

output "bucket_domain_name" {
  description = "The bucket domain name"
  value       = aws_s3_bucket.this.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "The bucket region-specific domain name"
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}

output "bucket_hosted_zone_id" {
  description = "The Route 53 Hosted Zone ID for this bucket's region"
  value       = aws_s3_bucket.this.hosted_zone_id
}

output "bucket_region" {
  description = "The AWS region this bucket resides in"
  value       = aws_s3_bucket.this.region
}

# Website Configuration
output "bucket_website_endpoint" {
  description = "The website endpoint, if the bucket is configured with a website"
  value       = var.website_config != null ? aws_s3_bucket_website_configuration.this[0].website_endpoint : null
}

output "bucket_website_domain" {
  description = "The domain of the website endpoint, if the bucket is configured with a website"
  value       = var.website_config != null ? aws_s3_bucket_website_configuration.this[0].website_domain : null
}

output "bucket_versioning_enabled" {
  description = "Whether versioning is enabled on the bucket"
  value       = var.enable_versioning
}

output "bucket_public_read_enabled" {
  description = "Whether public read access is enabled"
  value       = var.enable_public_read
}

output "bucket_website_enabled" {
  description = "Whether website configuration is enabled"
  value       = var.website_config != null
}

output "bucket_kms_encrypted" {
  description = "Whether the bucket uses KMS encryption"
  value       = var.kms_key_id != null
}
