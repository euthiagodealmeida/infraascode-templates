variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "sa-east-1" # São Paulo region
}

variable "instance_name" {
  description = "Name for the EC2 instance"
  type        = string
  default     = "lab-ec2"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "AWS key pair name for SSH access"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Environment = "lab"
    Project     = "lab-ec2"
    CreatedBy   = "opentofu"
  }
}
