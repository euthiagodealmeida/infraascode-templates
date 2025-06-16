variable "name" {
  description = "Name of the security group"
  type        = string
}

variable "description" {
  description = "Description of the security group"
  type        = string
  default     = "Security group managed by Terraform"
}

variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
}

variable "ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    from_port                = number
    to_port                  = number
    protocol                 = string
    description              = optional(string)
    cidr_blocks              = optional(list(string))
    ipv6_cidr_blocks         = optional(list(string))
    prefix_list_ids          = optional(list(string))
    source_security_group_id = optional(string)
    self                     = optional(bool)
  }))
  default = []
}

variable "egress_rules" {
  description = "List of egress rules"
  type = list(object({
    from_port                = number
    to_port                  = number
    protocol                 = string
    description              = optional(string)
    cidr_blocks              = optional(list(string))
    ipv6_cidr_blocks         = optional(list(string))
    prefix_list_ids          = optional(list(string))
    source_security_group_id = optional(string)
    self                     = optional(bool)
  }))
  default = []
}

# Common rules for HTTP, HTTPS, SSH access and all outbound traffic
variable "allow_http_from_cidr" {
  description = "CIDR blocks to allow HTTP (port 80) access from"
  type        = list(string)
  default     = null
}

variable "allow_https_from_cidr" {
  description = "CIDR blocks to allow HTTPS (port 443) access from"
  type        = list(string)
  default     = null
}

variable "allow_ssh_from_cidr" {
  description = "CIDR blocks to allow SSH (port 22) access from"
  type        = list(string)
  default     = null
}

variable "allow_all_outbound" {
  description = "Whether to allow all outbound traffic"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to the security group"
  type        = map(string)
  default     = {}
}
