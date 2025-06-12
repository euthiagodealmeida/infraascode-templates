# 🚀 Infrastructure as Code Templates (Terraform/OpenTofu)

A collection of reusable Infrastructure as Code modules for AWS infrastructure. Each module is designed as a "Lego piece" that can be used independently or combined to build complex infrastructure.

## 📋 TODO

- **Refactor tagging: it needs to be more consistent**
- **Create better tfvars.examples (multi examples)**
- **Create a multi module (ec2+vpc) exameple**

## 🎯 Design Philosophy

- **Modular**: Each component is independent and reusable
- **Simple**: Clean, readable code with sensible defaults
- **Documented**: Comprehensive READMEs and examples
- **Professional**: Follows industry best practices
- **Flexible**: Easy to customize and extend

## 📁 Structure

```
terraform-templates/
├── aws/
│   ├── dynamodb/               # DynamoDB table module
│   ├── ec2/                    # EC2 instance module
│   ├── s3/                     # S3 bucket module
│   └── vpc/                    # VPC networking module
├── examples/                   # Practical examples
│   ├── dynamodb/               # DynamoDB state lock example
│   ├── ec2/                    # EC2 web server example
│   ├── s3/                     # S3 bucket example
│   └── vpc/                    # VPC basic example
└── README.md
```

## 🧩 Modules

### AWS Modules
- **[DynamoDB](./aws/dynamodb/)** - Simple, configurable DynamoDB tables
- **[EC2](./aws/ec2/)** - Simple, configurable EC2 instances with security groups
- **[S3](./aws/s3/)** - S3 buckets with encryption and security defaults
- **[VPC](./aws/vpc/)** - VPC with auto-calculated subnets and NAT gateway support

## 📚 Examples

- **[DynamoDB Table](./examples/dynamodb/)** - Simple DynamoDB table (could be used for state locking)
- **[EC2 Simple Web Server](./examples/ec2/)** - Complete web server setup with Apache
- **[S3 Basic Bucket](./examples/s3/)** - Basic S3 bucket with secure defaults
- **[VPC Basic Setup](./examples/vpc/)** - VPC with auto-calculated subnets

## 🚀 Quick Start

1. **Choose a module or example**
2. **Copy the configuration:**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```
3. **Edit with your values**
4. **Deploy (using OpenTofu):**
   ```bash
   tofu init
   tofu plan
   tofu apply
   ```