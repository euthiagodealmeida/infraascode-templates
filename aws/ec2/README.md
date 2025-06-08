# AWS EC2 Instance Module

Simple and reusable EC2 instance module for OpenTofu.

## Features

- 🚀 Creates EC2 instance with sensible defaults
- 🔒 Automatic security group with SSH, HTTP, HTTPS access
- 💾 Encrypted EBS volume by default
- 🏷️ Flexible tagging system
- 🌐 Uses default VPC/subnet if not specified

## Usage

### Basic Example

```hcl
module "web_server" {
  source = "./ec2"

  name         = "my-web-server"
  instance_type = "t3.micro"
  key_name     = "my-key-pair"

  tags = {
    Environment = "production"
    Project     = "web-app"
  }
}
```

### Advanced Example

```hcl
module "app_server" {
  source = "./ec2"

  name                = "app-server"
  instance_type       = "t3.small"
  key_name           = "production-key"
  associate_public_ip = false
  volume_size        = 30
  volume_type        = "gp3"

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y docker
    systemctl start docker
  EOF
  )

  tags = {
    Environment = "production"
    Application = "backend"
    Team        = "devops"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | Name for the EC2 instance | `string` | `"ec2-instance"` | no |
| instance_type | EC2 instance type | `string` | `"t3.micro"` | no |
| ami_id | AMI ID (uses latest Amazon Linux 2 if not specified) | `string` | `null` | no |
| key_name | AWS Key Pair name for SSH access | `string` | `null` | no |
| associate_public_ip | Associate public IP address | `bool` | `true` | no |
| volume_type | EBS volume type | `string` | `"gp3"` | no |
| volume_size | EBS volume size in GB | `number` | `20` | no |
| encrypted | Enable EBS encryption | `bool` | `true` | no |
| user_data | User data script | `string` | `null` | no |
| tags | Tags to apply to resources | `map(string)` | `{"Environment"="dev", "ManagedBy"="opentofu"}` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance_id | EC2 instance ID |
| public_ip | Public IP address |
| private_ip | Private IP address |
| public_dns | Public DNS name |
| security_group_id | Security group ID |
| availability_zone | Availability zone |

## Security

- Security group allows SSH (22), HTTP (80), and HTTPS (443) from anywhere
- All egress traffic allowed
- EBS encryption enabled by default
- **Important**: Restrict SSH access in production environments

## Requirements

- OpenTofu >= 1.0
- AWS Provider ~> 5.0
- Configured AWS credentials

## Quick Start

1. Clone this module or copy the files
2. Create a `terraform.tfvars` file:
   ```hcl
   name     = "my-server"
   key_name = "your-key-pair"
   ```
3. Run:
   ```bash
   tofu init
   tofu plan
   tofu apply
   ```

## 📖 Examples

Check out the AWS examples directory for complete working examples:

### Simple Web Server
```bash
cd ../examples/ec2-simple-web-server
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your key pair name
tofu init && tofu apply
```

## 🧩 Integration with Other Modules

This module is designed to be a "Lego piece" that can be combined with other infrastructure modules:

```hcl
# VPC Module (future)
module "vpc" {
  source = "../vpc"
  # vpc configuration
}

# EC2 in custom VPC
module "web_server" {
  source = "../ec2"
  
  name      = "web-server"
  subnet_id = module.vpc.public_subnet_ids[0]
  vpc_id    = module.vpc.vpc_id
}
```
