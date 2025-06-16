# AWS Application Load Balancer (ALB) Module

A simple, configurable Application Load Balancer module designed as a reusable "Lego piece" for AWS container and web application infrastructure.

## ✨ Features

- 🌐 **Internet-facing load balancer** - Routes traffic from internet to your applications
- 🔒 **SSL/TLS termination** - Handles HTTPS certificates and encryption
- ⚖️ **Load balancing** - Distributes traffic across healthy targets
- 🩺 **Health checking** - Monitors application health automatically
- 🔄 **HTTP to HTTPS redirect** - Enforces secure connections
- 🎯 **Target group management** - Groups application instances
- 🏷️ **Flexible configuration** - Sensible defaults with customization options

## 🚀 Usage

### Basic ALB for HTTP Applications

```hcl
module "app_alb" {
  source = "../../aws/alb"
  
  alb_name           = "my-app-alb"
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = [module.alb_security_group.security_group_id]
  
  target_group_name = "my-app-targets"
  target_port       = 8080
  health_check_path = "/health"
  
  # HTTP only (no SSL certificate)
  enable_https_listener = false
  enable_http_redirect  = false
  
  tags = {
    Environment = "development"
    Project     = "my-app"
  }
}
```

### Production ALB with HTTPS

```hcl
module "prod_alb" {
  source = "../../aws/alb"
  
  alb_name           = "prod-api-alb"
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = [module.alb_security_group.security_group_id]
  
  target_group_name = "prod-api-targets"
  target_port       = 8080
  health_check_path = "/health"
  
  # HTTPS with SSL certificate
  enable_https_listener = true
  certificate_arn       = module.acm_certificate.certificate_arn
  enable_http_redirect  = true
  
  tags = {
    Environment = "production"
    Project     = "api"
  }
}
```

## 🔧 Dependencies

This module requires:
- **VPC** - Virtual Private Cloud
- **Public Subnets** - For internet-facing ALB
- **Security Groups** - To control traffic
- **SSL Certificate** - For HTTPS (optional)


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alb_name | The name of the Application Load Balancer | `string` | n/a | yes |
| vpc_id | The VPC ID where the target group will be created | `string` | n/a | yes |
| subnet_ids | List of subnet IDs for the ALB (should be public subnets) | `list(string)` | n/a | yes |
| security_group_ids | List of security group IDs to assign to the ALB | `list(string)` | n/a | yes |
| target_group_name | The name of the target group | `string` | n/a | yes |
| internal | If true, the ALB will be internal (not internet-facing) | `bool` | `false` | no |
| target_port | The port on which targets receive traffic | `number` | `8080` | no |
| health_check_path | The destination for health checks on the targets | `string` | `"/health"` | no |
| enable_deletion_protection | If true, deletion of the load balancer will be disabled | `bool` | `true` | no |
| healthy_threshold | Number of consecutive health check successes required | `number` | `2` | no |
| health_check_interval | Time between health checks (seconds) | `number` | `30` | no |
| health_check_timeout | Health check timeout (seconds) | `number` | `5` | no |
| unhealthy_threshold | Number of consecutive health check failures required | `number` | `3` | no |
| health_check_matcher | HTTP codes for successful response | `string` | `"200"` | no |
| certificate_arn | The ARN of the SSL certificate for HTTPS listener | `string` | `null` | no |
| ssl_policy | The name of the SSL Policy for the listener | `string` | `"ELBSecurityPolicy-TLS-1-2-2017-01"` | no |
| enable_https_listener | Whether to create HTTPS listener | `bool` | `true` | no |
| enable_http_redirect | Whether to redirect HTTP traffic to HTTPS | `bool` | `true` | no |
| tags | Tags to apply to ALB resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| alb_id | The ID of the load balancer |
| alb_arn | The ARN of the load balancer |
| alb_dns_name | The DNS name of the load balancer |
| alb_zone_id | The canonical hosted zone ID of the load balancer |
| target_group_arn | The ARN of the target group |
| target_group_name | The name of the target group |
| http_listener_arn | The ARN of the HTTP listener |
| https_listener_arn | The ARN of the HTTPS listener |
| alb_security_groups | The security groups assigned to the load balancer |
| alb_subnets | The subnets assigned to the load balancer |

## Requirements

| Name | Version |
|------|---------|
| terraform/opentofu | >= 1.0 |
| aws | >= 5.0 |