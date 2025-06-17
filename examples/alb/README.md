# ALB Module Example

This example demonstrates how to use the ALB module to create an Application Load Balancer.

## Prerequisites

Before using this example, you must have:

1. **Existing VPC** - Use the VPC module or existing VPC
2. **Public Subnets** - At least 2 subnets in different AZs
3. **Security Groups** - ALB security group with appropriate rules
4. **SSL Certificate** (optional) - For HTTPS listeners

## Usage

1. **Copy the configuration:**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. **Update terraform.tfvars with your values:**
   ```hcl
   vpc_id = "vpc-your-vpc-id"
   subnet_ids = [
     "subnet-your-subnet-1",
     "subnet-your-subnet-2"
   ]
   security_group_ids = ["sg-your-alb-sg"]
   ```

3. **Deploy:**
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `alb_name` | Name of the ALB | `string` | n/a | ✅ |
| `vpc_id` | VPC ID | `string` | n/a | ✅ |
| `subnet_ids` | List of subnet IDs | `list(string)` | n/a | ✅ |
| `security_group_ids` | List of security group IDs | `list(string)` | n/a | ✅ |
| `target_group_name` | Target group name | `string` | n/a | ✅ |
| `target_port` | Target port | `number` | `8080` | ❌ |
| `certificate_arn` | SSL certificate ARN | `string` | `""` | ❌ |

## Outputs

| Name | Description |
|------|-------------|
| `alb_dns_name` | DNS name of the ALB |
| `alb_arn` | ARN of the ALB |
| `target_group_arn` | ARN of the target group |
| `http_listener_arn` | ARN of HTTP listener |
| `https_listener_arn` | ARN of HTTPS listener |