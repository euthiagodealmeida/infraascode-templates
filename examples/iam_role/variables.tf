variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "sa-east-1"
}

variable "role_name" {
  description = "Name of the IAM role"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Environment = "lab"
    Project     = "lab-iam-role-demo"
  }
}
