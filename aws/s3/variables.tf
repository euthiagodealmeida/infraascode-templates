variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
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
  description = "The AWS KMS key ID for S3 bucket encryption (if null, uses AES256)"
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
  description = "Tags to apply to the S3 bucket"
  type        = map(string)
  default = {
    ManagedBy = "terraform"
  }
}
