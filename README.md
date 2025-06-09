# 🚀 Infrastructure as Code Templates (Terraform/OpenTofu)

A collection of reusable Infrastructure as Code modules for AWS infrastructure. Each module is designed as a "Lego piece" that can be used independently or combined to build complex infrastructure.

## 📋 TODO

- 🏷️ **Consistent tagging**

## 📁 Structure

```
terraform-templates/
├── aws/
│   ├── ec2/                    # EC2 instance module
│   ├── s3/                     # S3 bucket module
│   ├── vpc/                    # VPC networking module
│   └── examples/               # Practical examples
│       ├── ec2/                # EC2 web server example
│       └── s3/                 # S3 bucket example
└── README.md
```

## 🧩 Modules

### AWS Modules
- **[EC2](./aws/ec2/)** - Simple, configurable EC2 instances with security groups
- **[S3](./aws/s3/)** - S3 buckets with encryption and security defaults
- **[VPC](./aws/vpc/)** - VPC with auto-calculated subnets and NAT gateway support

## 📚 Examples

- **[EC2 Simple Web Server](./aws/examples/ec2/)** - Complete web server setup with Apache
- **[S3 Basic Bucket](./aws/examples/s3/)** - Basic S3 bucket with secure defaults

## 🚀 Quick Start

1. **Choose a module or example**
2. **Copy the configuration:**
   ```bash
   cp whatever.tfvars.example whatever.tfvars
   ```
3. **Edit with your values**
4. **Deploy (using OpenTofu):**
   ```bash
   tofu init
   tofu plan
   tofu apply
   ```

## 🎯 Design Philosophy

- **Modular**: Each component is independent and reusable
- **Simple**: Clean, readable code with sensible defaults
- **Documented**: Comprehensive READMEs and examples
- **Professional**: Follows industry best practices
- **Flexible**: Easy to customize and extend
