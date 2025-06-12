variable "repository_name" {
  description = "The name of the ECR repository"
  type        = string
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository (MUTABLE or IMMUTABLE)"
  type        = string
  default     = "MUTABLE"

  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "Image tag mutability must be either MUTABLE or IMMUTABLE."
  }
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

  validation {
    condition     = contains(["AES256", "KMS"], var.encryption_type)
    error_message = "Encryption type must be either AES256 or KMS."
  }
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

# Permissions
variable "enable_repository_policy" {
  description = "Enable repository permissions for cross-account or service access"
  type        = bool
  default     = false
}

variable "repository_policy" {
  description = "Custom repository permission policy JSON. If not provided, a default policy will be used"
  type        = string
  default     = null
}

variable "allowed_principals" {
  description = "List of AWS principals (account IDs, ARNs) allowed to access the repository"
  type        = list(string)
  default     = []
}