variable "name" {
  description = "Name for the EC2 instance"
  type        = string
  default     = "ec2-instance"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID (optional, defaults to latest Amazon Linux 2)"
  type        = string
  default     = null
}

variable "key_name" {
  description = "AWS Key Pair name for SSH access"
  type        = string
  default     = null
}

variable "associate_public_ip" {
  description = "Associate public IP address"
  type        = bool
  default     = true
}

variable "volume_type" {
  description = "EBS volume type"
  type        = string
  default     = "gp3"
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

variable "user_data" {
  description = "User data script"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Environment = "lab"
    ManagedBy   = "opentofu"
  }
}
