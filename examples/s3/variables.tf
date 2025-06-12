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

variable "enable_versioning" {
  description = "Enable versioning on the S3 bucket"
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "The AWS KMS key ID for S3 bucket encryption"
  type        = string
  default     = null
}

variable "bucket_key_enabled" {
  description = "Whether to use S3 Bucket Key for SSE-KMS"
  type        = bool
  default     = true
}

variable "enable_public_read" {
  description = "Enable public read access to the bucket"
  type        = bool
  default     = false
}

variable "website_config" {
  description = "Website configuration for the S3 bucket"
  type = object({
    index_document = string
    error_document = string
  })
  default = null
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
