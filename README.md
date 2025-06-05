# 🚀 OpenTofu Templates

A collection of reusable OpenTofu modules for AWS infrastructure. Each module is designed as a "Lego piece" that can be used independently or combined to build complex infrastructure.

## 📁 Structure

```
opentofu-templates/
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
   cp opentofu.tfvars.example opentofu.tfvars
   ```
3. **Edit with your values**
4. **Deploy:**
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

## 💼 For Recruiters

This repository demonstrates:
- Infrastructure as Code expertise
- OpenTofu best practices
- AWS cloud platform knowledge
- Clean code organization
- Professional documentation
- Modular architecture design

Each module includes comprehensive documentation, working examples, and follows industry standards for infrastructure automation.