# AWS EC2 Module

A simple, configurable EC2 instance module designed as a reusable "Lego piece" for AWS infrastructure.

## 📁 Module Structure

```
aws/ec2/
├── ec2.tf                 # Core EC2 instance resource
├── security.tf           # Security group configuration
├── data.tf               # Data sources (AMI, VPC, subnets)
├── variables.tf          # Input variables
├── outputs.tf            # Module outputs
├── versions.tf           # Provider requirements
└── README.md             # Documentation
```

## ✨ Features

- 🔐 **Secure by default** - EBS encryption enabled, proper security group
- 🚀 **Latest AMI** - Automatically uses latest Amazon Linux 2
- 🌐 **Default VPC ready** - Works out of the box with default VPC
- 🔑 **SSH ready** - Optional key pair for SSH access
- 💾 **Encrypted storage** - EBS encryption enabled by default
- 🏷️ **Consistent tagging** - Merge custom tags with defaults
- 🧩 **Modular design** - Each feature in its own file for clarity

## 🚀 Usage

### Basic Instance
```hcl
module "web_server" {
  source = "../../aws/ec2"
  
  name         = "my-web-server"
  instance_type = "t3.micro"
  key_name     = "my-key-pair"
  
  tags = {
    Environment = "production"
    Project     = "web-app"
  }
}
```

### Custom Storage Instance
```hcl
module "app_server" {
  source = "../../aws/ec2"
  
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

### Instance with Custom AMI
```hcl
module "custom_server" {
  source = "../ec2"
  
  name          = "custom-app"
  instance_type = "t3.medium"
  ami_id        = "ami-12345678"  # Your custom AMI
  key_name      = "my-key"
  
  tags = {
    Environment = "staging"
    Project     = "custom-app"
  }
}
```

## 📋 Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `name` | Name for the EC2 instance | `string` | `"ec2-instance"` | ❌ |
| `instance_type` | EC2 instance type | `string` | `"t3.micro"` | ❌ |
| `ami_id` | AMI ID (uses latest Amazon Linux 2 if null) | `string` | `null` | ❌ |
| `key_name` | AWS Key Pair name for SSH access | `string` | `null` | ❌ |
| `associate_public_ip` | Associate public IP address | `bool` | `true` | ❌ |
| `volume_type` | EBS volume type | `string` | `"gp3"` | ❌ |
| `volume_size` | EBS volume size in GB | `number` | `20` | ❌ |
| `encrypted` | Enable EBS encryption | `bool` | `true` | ❌ |
| `user_data` | User data script (base64 encoded) | `string` | `null` | ❌ |
| `tags` | Tags to apply to resources | `map(string)` | `{Environment="lab", ManagedBy="opentofu"}` | ❌ |

## 📤 Outputs

| Name | Description |
|------|-------------|
| `instance_id` | EC2 instance ID |
| `public_ip` | Public IP address |
| `private_ip` | Private IP address |
| `public_dns` | Public DNS name |
| `security_group_id` | Security group ID |
| `availability_zone` | Availability zone |
| `subnet_id` | Subnet ID where the instance is deployed |
| `vpc_id` | VPC ID where the instance is deployed |
| `ami_id` | AMI ID used for the instance |
| `instance_type` | Instance type |
| `key_name` | Key pair name used for SSH access |
| `encrypted` | Whether EBS encryption is enabled |
| `associate_public_ip` | Whether public IP is associated |

## 🔒 Security Features

- **🛡️ Secure by default**: Encrypted EBS volumes, proper security group
- **🔐 EBS encryption**: All volumes encrypted by default
- **🌐 Network security**: Security group allows SSH, HTTP, HTTPS with egress control
- **🔑 SSH access**: Optional key pair configuration for secure access
- **🏷️ Resource tagging**: Consistent tagging for security and compliance

## 📝 Requirements

| Name | Version |
|------|---------|
| opentofu/terraform | >= 1.0 |
| aws | ~> 5.0 |