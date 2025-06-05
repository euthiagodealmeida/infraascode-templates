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

output "bucket_encryption" {
  description = "The encryption configuration of the bucket"
  value       = module.lab-s3.bucket_encryption
}

output "bucket_tags" {
  description = "All tags applied to the bucket"
  value       = module.lab-s3.bucket_tags
}
