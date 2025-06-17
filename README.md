# 🚀 Infrastructure as Code Templates (Terraform/OpenTofu)

A collection of reusable Infrastructure as Code modules for AWS infrastructure. Each module is designed as a "Lego piece" that can be used independently or combined to build complex infrastructure.

## 📋 TODO

- **Add ECS module for container orchestration**
- **Create RDS module for database management**
- **Add CloudWatch module for monitoring and logging**
- **Create Lambda module for serverless functions**
- **Add multi-module examples (e.g., VPC + ALB + ECS)**

## 🎯 Design Philosophy

- **Modular**: Each component is independent and reusable
- **Simple**: Clean, readable code with sensible defaults
- **Documented**: Comprehensive READMEs and examples
- **Professional**: Follows industry best practices
- **Flexible**: Easy to customize and extend

## 📁 Structure

```
infraascode-templates/
├── aws/
│   ├── alb/                    # Application Load Balancer module
│   ├── dynamodb/               # DynamoDB table module
│   ├── ec2/                    # EC2 instance module
│   ├── ecr/                    # ECR container registry module
│   ├── iam_role/               # IAM role with policy attachments module
│   ├── s3/                     # S3 bucket module
│   ├── security_group/         # Security group module
│   └── vpc/                    # VPC networking module
├── examples/                   # Practical examples
│   ├── alb/                    # ALB with target groups example
│   ├── dynamodb/               # DynamoDB state lock example
│   ├── ec2/                    # EC2 web server example
│   ├── ecr/                    # ECR container registry example
│   ├── iam_role/               # IAM role with policy attachments example
│   ├── s3/                     # S3 bucket example
│   ├── security_group/         # Security group with rules example
│   └── vpc/                    # VPC basic example
└── README.md
```

## 🧩 Modules

### AWS Modules
- **[Application Load Balancer](./aws/alb/)** - ALB with listeners and target groups
- **[DynamoDB](./aws/dynamodb/)** - Simple, configurable DynamoDB tables for state locking
- **[EC2](./aws/ec2/)** - Simple, configurable EC2 instances with security groups
- **[ECR](./aws/ecr/)** - Container registry for Docker images with lifecycle management
- **[IAM Role](./aws/iam_role/)** - IAM roles with policy attachments (AWS managed, customer managed, and inline)
- **[S3](./aws/s3/)** - S3 buckets with encryption and security defaults
- **[Security Group](./aws/security_group/)** - Security groups with ingress and egress rules
- **[VPC](./aws/vpc/)** - VPC with auto-calculated subnets and NAT gateway support

## 📚 Examples

- **[ALB Example](./examples/alb/)** - Complete load balancer setup with target groups
- **[DynamoDB State Lock](./examples/dynamodb/)** - Simple, configurable DynamoDB tables for state locking
- **[EC2 Simple Web Server](./examples/ec2/)** - Complete web server setup with Apache
- **[ECR Container Registry](./examples/ecr/)** - Docker image registry for containerized applications
- **[IAM Role Example](./examples/iam_role/)** - ECS task role with policy attachments
- **[S3 Basic Bucket](./examples/s3/)** - Basic S3 bucket with secure defaults
- **[Security Group Example](./examples/security_group/)** - Security group with HTTP/HTTPS rules
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