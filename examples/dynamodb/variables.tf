variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "sa-east-1" # São Paulo region
}

variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
  default     = "lab-dynamodb-table"
}

variable "billing_mode" {
  description = "Controls billing mode (PROVISIONED or PAY_PER_REQUEST)"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "hash_key" {
  description = "The attribute to use as the hash (partition) key"
  type        = string
  default     = "LockID"
}

variable "range_key" {
  description = "The attribute to use as the range (sort) key"
  type        = string
  default     = null
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
  default     = false  # Disabled for lab environment
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Environment = "lab"
    Project     = "lab-dynamodb"
    Owner       = "euthiagodealmeida"
    CreatedBy   = "opentofu"
  }
}
