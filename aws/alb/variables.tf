variable "alb_name" {
  description = "The name of the Application Load Balancer"
  type        = string
}

variable "internal" {
  description = "If true, the ALB will be internal (not internet-facing)"
  type        = bool
  default     = false
}

variable "security_group_ids" {
  description = "List of security group IDs to assign to the ALB"
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ALB (should be public subnets for internet-facing ALB)"
  type        = list(string)
}

variable "enable_deletion_protection" {
  description = "If true, deletion of the load balancer will be disabled via the AWS API"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "The VPC ID where the target group will be created"
  type        = string
}

variable "target_group_name" {
  description = "The name of the target group"
  type        = string
}

variable "target_port" {
  description = "The port on which targets receive traffic"
  type        = number
  default     = 8080
}

variable "health_check_path" {
  description = "The destination for health checks on the targets"
  type        = string
  default     = "/health"
}

variable "healthy_threshold" {
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  type        = number
  default     = 2
}

variable "health_check_interval" {
  description = "The approximate amount of time, in seconds, between health checks of an individual target"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "The amount of time, in seconds, during which no response means a failed health check"
  type        = number
  default     = 5
}

variable "unhealthy_threshold" {
  description = "The number of consecutive health check failures required before considering the target unhealthy"
  type        = number
  default     = 3
}

variable "health_check_matcher" {
  description = "The HTTP codes to use when checking for a successful response from a target"
  type        = string
  default     = "200"
}

variable "certificate_arn" {
  description = "The ARN of the SSL certificate for HTTPS listener"
  type        = string
  default     = null
}

variable "ssl_policy" {
  description = "The name of the SSL Policy for the listener"
  type        = string
  default     = "ELBSecurityPolicy-TLS-1-2-2017-01"
}

variable "enable_https_listener" {
  description = "Whether to create HTTPS listener (requires certificate_arn)"
  type        = bool
  default     = true
}

variable "enable_http_redirect" {
  description = "Whether to redirect HTTP traffic to HTTPS"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to ALB resources"
  type        = map(string)
  default     = {}
}
