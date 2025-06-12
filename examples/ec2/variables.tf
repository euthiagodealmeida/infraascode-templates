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
  default     = "t3.micro"
}

variable "key_name" {
  description = "AWS key pair name for SSH access"
  type        = string
}

variable "associate_public_ip" {
  description = "Associate public IP address"
  type        = bool
  default     = true
}

variable "volume_size" {
  description = "EBS volume size in GB"
  type        = number
  default     = 20
}

variable "encrypted" {
  description = "Enable EBS encryption"
  type        = bool
  default     = true
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
