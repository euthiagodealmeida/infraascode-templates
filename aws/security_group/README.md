# AWS Security Group Module

A flexible, reusable Terraform module for creating AWS Security Groups with customizable ingress and egress rules.

## Features

- **Flexible Rule Management** - Define custom ingress/egress rules with full control
- **Predefined Common Rules** - Quick setup for HTTP, HTTPS, SSH access
- **Security Group References** - Rules can reference other security groups
- **Multiple Rule Sources** - Support for CIDR blocks, IPv6, prefix lists, and self-references
- **Automatic Tagging** - Consistent tagging with Name and ManagedBy tags

## Usage

### Basic Security Group with Custom Rules

```hcl
module "app_security_group" {
  source = "../../aws/security_group"

  name        = "app-sg"
  description = "Security group for application servers"
  vpc_id      = var.vpc_id

  ingress_rules = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/16"]
      description = "Application port from VPC"
    },
    {
      from_port                = 22
      to_port                  = 22
      protocol                 = "tcp"
      source_security_group_id = var.bastion_sg_id
      description              = "SSH from bastion"
    }
  ]

  egress_rules = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTPS to internet"
    }
  ]

  tags = {
    Environment = "production"
    Team        = "backend"
  }
}
```

### ALB Security Group (Common Pattern)

```hcl
module "alb_security_group" {
  source = "../../aws/security_group"

  name        = "alb-sg"
  description = "Security group for Application Load Balancer"
  vpc_id      = var.vpc_id

  # Quick setup for ALB
  allow_http_from_cidr  = ["0.0.0.0/0"]
  allow_https_from_cidr = ["0.0.0.0/0"]
  allow_all_outbound    = true

  tags = {
    Environment = "production"
    Component   = "loadbalancer"
  }
}
```

### Backend Security Group (ECS/EC2)

```hcl
module "backend_security_group" {
  source = "../../aws/security_group"

  name        = "backend-sg"
  description = "Security group for backend services"
  vpc_id      = var.vpc_id

  ingress_rules = [
    {
      from_port                = 8080
      to_port                  = 8080
      protocol                 = "tcp"
      source_security_group_id = module.alb_security_group.security_group_id
      description              = "App port from ALB"
    }
  ]

  allow_all_outbound = true

  tags = {
    Environment = "production"
    Component   = "backend"
  }
}
```

## Variables

### Required Variables

| Name | Description | Type |
|------|-------------|------|
| `name` | Name of the security group | `string` |
| `vpc_id` | VPC ID where the security group will be created | `string` |

### Optional Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `name` | Name of the security group | `string` | Required |
| `description` | Description of the security group | `string` | `"Security group managed by Terraform"` |
| `ingress_rules` | List of ingress rules | `list(object)` | `[]` |
| `egress_rules` | List of egress rules | `list(object)` | `[]` |
| `allow_http_from_cidr` | CIDR blocks to allow HTTP (port 80) access from | `list(string)` | `null` |
| `allow_https_from_cidr` | CIDR blocks to allow HTTPS (port 443) access from | `list(string)` | `null` |
| `allow_ssh_from_cidr` | CIDR blocks to allow SSH (port 22) access from | `list(string)` | `null` |
| `allow_all_outbound` | Whether to allow all outbound traffic | `bool` | `true` |
| `tags` | Tags to apply to the security group | `map(string)` | `{}` |

### Rule Object Structure

```hcl
{
  from_port                = number
  to_port                  = number
  protocol                 = string           # "tcp", "udp", "icmp", or "-1"
  description              = string           # Optional
  cidr_blocks              = list(string)     # Optional
  ipv6_cidr_blocks         = list(string)     # Optional
  prefix_list_ids          = list(string)     # Optional
  source_security_group_id = string          # Optional
  self                     = bool             # Optional
}
```

## Outputs

| Name | Description |
|------|-------------|
| `security_group_id` | ID of the security group |
| `security_group_arn` | ARN of the security group |
| `security_group_name` | Name of the security group |
| `security_group_description` | Description of the security group |
| `security_group_vpc_id` | VPC ID of the security group |
| `security_group_owner_id` | Owner ID of the security group |
| `ingress_rule_ids` | IDs of the ingress rules |
| `egress_rule_ids` | IDs of the egress rules |

## Common Patterns

### Three-Tier Architecture

```hcl
# ALB Security Group
module "alb_sg" {
  source = "../../aws/security_group"
  name   = "alb-sg"
  vpc_id = var.vpc_id
  
  allow_http_from_cidr  = ["0.0.0.0/0"]
  allow_https_from_cidr = ["0.0.0.0/0"]
}

# App Security Group
module "app_sg" {
  source = "../../aws/security_group"
  name   = "app-sg"
  vpc_id = var.vpc_id
  
  ingress_rules = [{
    from_port                = 8080
    to_port                  = 8080
    protocol                 = "tcp"
    source_security_group_id = module.alb_sg.security_group_id
    description              = "App port from ALB"
  }]
}

# Database Security Group
module "db_sg" {
  source = "../../aws/security_group"
  name   = "db-sg"
  vpc_id = var.vpc_id
  
  ingress_rules = [{
    from_port                = 5432
    to_port                  = 5432
    protocol                 = "tcp"
    source_security_group_id = module.app_sg.security_group_id
    description              = "PostgreSQL from app"
  }]
}
```