variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "sa-east-1"
}

variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
}

variable "name" {
  description = "Name of the security group"
  type        = string
}

variable "description" {
  description = "Description of the security group"
  type        = string
  default     = "Security group managed by Terraform"
}

variable "allow_http_from_cidr" {
  description = "List of CIDR blocks allowed to access HTTP (port 80)"
  type        = list(string)
  default     = []
}

variable "allow_https_from_cidr" {
  description = "List of CIDR blocks allowed to access HTTPS (port 443)"
  type        = list(string)
  default     = []
}

variable "allow_ssh_from_cidr" {
  description = "List of CIDR blocks allowed to access SSH (port 22)"
  type        = list(string)
  default     = []
}

variable "allow_all_outbound" {
  description = "Allow all outbound traffic"
  type        = bool
  default     = true
}

variable "ingress_rules" {
  description = "List of custom ingress rules"
  type = list(object({
    from_port                = number
    to_port                  = number
    protocol                 = string
    cidr_blocks              = optional(list(string))
    ipv6_cidr_blocks         = optional(list(string))
    prefix_list_ids          = optional(list(string))
    source_security_group_id = optional(string)
    self                     = optional(bool)
    description              = optional(string)
  }))
  default = []
}

variable "egress_rules" {
  description = "List of custom egress rules"
  type = list(object({
    from_port                = number
    to_port                  = number
    protocol                 = string
    cidr_blocks              = optional(list(string))
    ipv6_cidr_blocks         = optional(list(string))
    prefix_list_ids          = optional(list(string))
    source_security_group_id = optional(string)
    self                     = optional(bool)
    description              = optional(string)
  }))
  default = []
}

variable "tags" {
  description = "Tags to apply to the security group"
  type        = map(string)
  default = {
    ManagedBy = "opentofu"
  }
}
