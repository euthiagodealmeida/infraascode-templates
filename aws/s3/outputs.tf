output "bucket_id" {
  description = "The name/ID of the bucket"
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

output "bucket_website_endpoint" {
  description = "The website endpoint, if the bucket is configured with a website"
  value       = var.website_endpoint
}

output "bucket_website_domain" {
  description = "The domain of the website endpoint"
  value       = var.website_domain
}

output "bucket_versioning_status" {
  description = "The versioning state of the bucket"
  value       = var.versioning_status
}

output "bucket_encryption_algorithm" {
  description = "The encryption algorithm used for the bucket"
  value       = var.sse_algorithm
}

output "bucket_kms_key_id" {
  description = "The KMS key ID used for bucket encryption"
  value       = var.kms_key_id
}

output "bucket_key_enabled" {
  description = "Whether S3 Bucket Key is enabled for SSE-KMS"
  value       = var.bucket_key_enabled
}

output "bucket_policy_attached" {
  description = "Whether a bucket policy is attached"
  value       = var.bucket_policy_count > 0
}

output "bucket_website_enabled" {
  description = "Whether website configuration is enabled"
  value       = var.website_config_count > 0
}

output "bucket_tags" {
  description = "All tags applied to the bucket"
  value       = var.tags
}
