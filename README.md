# 🚀 Infrastruce as code Templates (Terraform/Opentofu)

A collection of reusable Infrastructure as Code modules for AWS infrastructure. Each module is designed as a "Lego piece" that can be used independently or combined to build complex infrastructure.

## 📁 Structure

```
iac-templates/
├── aws/
│   ├── ec2/                    # EC2 instance module
│   ├── examples/               # Practical examples
│   │   └── ec2-simple-web-server/
│   └── [future modules]/      # VPC, RDS, etc.
└── README.md
```

## 🧩 Modules

### AWS Modules
- **[EC2](./aws/ec2/)** - Simple, configurable EC2 instances with security groups

## 📚 Examples

- **[EC2 Simple Web Server](./aws/examples/ec2-simple-web-server/)** - Complete web server setup with Apache

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

## TODO

- **Consistent tagging**