variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "sa-east-1" # São Paulo region
}

variable "bucket_name" {
  description = "Name for the S3 bucket"
  type        = string
  default     = "lab-s3-bucket-2025-example"
}

variable "force_destroy" {
  description = "Allow deletion of non-empty bucket"
  type        = bool
  default     = false
}

variable "versioning_status" {
  description = "Versioning status for the S3 bucket"
  type        = string
  default     = "Enabled"
}

variable "sse_algorithm" {
  description = "Server-side encryption algorithm"
  type        = string
  default     = "AES256"
}

variable "kms_key_id" {
  description = "The AWS KMS key ID for S3 bucket encryption"
  type        = string
  default     = null
}

variable "bucket_key_enabled" {
  description = "Whether to use S3 Bucket Key for SSE-KMS"
  type        = bool
  default     = false
}

variable "block_public_acls" {
  description = "Whether to block public ACLs"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether to block public bucket policies"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Whether to ignore public ACLs"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Whether to restrict public bucket policies"
  type        = bool
  default     = true
}

variable "bucket_policy_count" {
  description = "Number of bucket policies to create (0 or 1)"
  type        = number
  default     = 0
}

variable "public_read_policy" {
  description = "JSON policy document for public read access"
  type        = string
  default     = ""
}

variable "website_config_count" {
  description = "Number of website configurations to create (0 or 1)"
  type        = number
  default     = 0
}

variable "website_index_document" {
  description = "Index document for website configuration"
  type        = string
  default     = "index.html"
}

variable "website_error_document" {
  description = "Error document for website configuration"
  type        = string
  default     = "error.html"
}

variable "website_endpoint" {
  description = "Website endpoint output value"
  type        = string
  default     = ""
}

variable "website_domain" {
  description = "Website domain output value"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Environment = "lab"
    ManagedBy   = "terraform"
    Project     = "s3-basic-example"
  }
}
