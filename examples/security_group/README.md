# Security Group Module Example

This example demonstrates how to use the Security Group module to create AWS Security Groups with flexible rules.

## Prerequisites

Before using this example, you must have:

1. **Existing VPC** - you need to know the VPC ID

## Usage

1. **Copy the configuration:**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. **Update terraform.tfvars with your values:**
   ```hcl
   vpc_id = "vpc-12345678"  # Your VPC ID
   name   = "my-security-group"
   ```

3. **Deploy:**
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## Examples

### Web Server Security Group
```hcl
allow_http_from_cidr  = ["0.0.0.0/0"]
allow_https_from_cidr = ["0.0.0.0/0"]
allow_ssh_from_cidr   = ["10.0.0.0/8"]
```

### API Server Security Group
```hcl
ingress_rules = [
  {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
    description = "API port from VPC"
  }
]
```

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `name` | Name of the security group | `string` | n/a | ✅ |
| `vpc_id` | VPC ID | `string` | n/a | ✅ |
| `description` | Security group description | `string` | `"Security group managed by Terraform"` | ❌ |
| `allow_http_from_cidr` | CIDR blocks for HTTP access | `list(string)` | `[]` | ❌ |
| `allow_https_from_cidr` | CIDR blocks for HTTPS access | `list(string)` | `[]` | ❌ |
| `allow_ssh_from_cidr` | CIDR blocks for SSH access | `list(string)` | `[]` | ❌ |
| `ingress_rules` | Custom ingress rules | `list(object)` | `[]` | ❌ |
| `egress_rules` | Custom egress rules | `list(object)` | `[]` | ❌ |
| `allow_all_outbound` | Allow all outbound traffic | `bool` | `true` | ❌ |

## Outputs

| Name | Description |
|------|-------------|
| `security_group_id` | ID of the security group |
| `security_group_arn` | ARN of the security group |
| `security_group_name` | Name of the security group |
| `ingress_rule_ids` | IDs of ingress rules |
| `egress_rule_ids` | IDs of egress rules |
