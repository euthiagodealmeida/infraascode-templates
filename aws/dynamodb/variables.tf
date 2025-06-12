variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}

variable "billing_mode" {
  description = "Controls billing mode (PROVISIONED or PAY_PER_REQUEST)"
  type        = string
  default     = "PAY_PER_REQUEST"
  
  validation {
    condition     = contains(["PROVISIONED", "PAY_PER_REQUEST"], var.billing_mode)
    error_message = "Billing mode must be either PROVISIONED or PAY_PER_REQUEST."
  }
}

variable "hash_key" {
  description = "The attribute to use as the hash (partition) key"
  type        = string
  default     = "LockID"
}

variable "hash_key_type" {
  description = "The attribute type for the hash key (S, N, or B)"
  type        = string
  default     = "S"
  
  validation {
    condition     = contains(["S", "N", "B"], var.hash_key_type)
    error_message = "Hash key type must be S (string), N (number), or B (binary)."
  }
}

variable "range_key" {
  description = "The attribute to use as the range (sort) key"
  type        = string
  default     = null
}

variable "range_key_type" {
  description = "The attribute type for the range key (S, N, or B)"
  type        = string
  default     = "S"
  
  validation {
    condition     = contains(["S", "N", "B"], var.range_key_type)
    error_message = "Range key type must be S (string), N (number), or B (binary)."
  }
}

variable "read_capacity" {
  description = "The number of read units (only applies to PROVISIONED billing mode)"
  type        = number
  default     = 5
}

variable "write_capacity" {
  description = "The number of write units (only applies to PROVISIONED billing mode)"
  type        = number
  default     = 5
}

variable "enable_point_in_time_recovery" {
  description = "Enable point-in-time recovery for the table"
  type        = bool
  default     = true
}

variable "enable_encryption" {
  description = "Enable server-side encryption for the table"
  type        = bool
  default     = true
}

variable "deletion_protection_enabled" {
  description = "Enable deletion protection for the table"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to the DynamoDB table"
  type        = map(string)
  default = {
    ManagedBy = "opentofu"
  }
}
