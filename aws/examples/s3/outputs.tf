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

output "bucket_region" {
  description = "The AWS region this bucket resides in"
  value       = module.lab-s3.bucket_region
}

output "bucket_versioning_status" {
  description = "The versioning state of the bucket"
  value       = module.lab-s3.bucket_versioning_status
}

output "bucket_encryption_algorithm" {
  description = "The encryption algorithm used for the bucket"
  value       = module.lab-s3.bucket_encryption_algorithm
}

output "bucket_kms_key_id" {
  description = "The KMS key ID used for bucket encryption"
  value       = module.lab-s3.bucket_kms_key_id
}

output "bucket_key_enabled" {
  description = "Whether S3 Bucket Key is enabled for SSE-KMS"
  value       = module.lab-s3.bucket_key_enabled
}

output "bucket_tags" {
  description = "All tags applied to the bucket"
  value       = module.lab-s3.bucket_tags
}
