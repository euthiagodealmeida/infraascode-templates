variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "sa-east-1"
}

variable "repository_name" {
  description = "The name of the ECR repository"
  type        = string
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository (MUTABLE or IMMUTABLE)"
  type        = string
  default     = "MUTABLE"
}

variable "force_delete" {
  description = "If true, will delete the repository even if it contains images"
  type        = bool
  default     = false
}

variable "scan_on_push" {
  description = "Indicates whether images are scanned after being pushed to the repository"
  type        = bool
  default     = true
}

variable "encryption_type" {
  description = "The encryption type to use for the repository (AES256 or KMS)"
  type        = string
  default     = "AES256"
}

variable "kms_key_id" {
  description = "The KMS key ID to use for encryption (only used when encryption_type is KMS)"
  type        = string
  default     = null
}

variable "enable_lifecycle_policy" {
  description = "Whether to enable lifecycle policy for the repository"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to the ECR repository"
  type        = map(string)
  default     = {}
}

# Permissions-related variables (optional - for advanced usage)
variable "enable_repository_policy" {
  description = "Enable repository permissions for cross-account or service access"
  type        = bool
  default     = false
}

variable "allowed_principals" {
  description = "List of AWS principals (account IDs, ARNs) allowed to access the repository"
  type        = list(string)
  default     = []
}