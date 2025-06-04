# AWS Examples

This directory contains practical examples demonstrating how to use the AWS modules in this repository. Each example is a complete, working configuration that showcases best practices and real-world use cases.

## 📁 Available Examples

### EC2 Examples
- **[ec2-free-tier](./ec2-free-tier/)** - Simple web server with Apache

## 🚀 Quick Start

Each example is self-contained and can be deployed independently:

```bash
# Navigate to any example
cd examples/ec2-free-tier

# Copy the example configuration
cp terraform.tfvars.example terraform.tfvars

# Edit with your values
nano terraform.tfvars

# Deploy
tofu init
tofu plan
tofu apply
```

## 🎯 Example Structure

Each example follows a consistent structure:

```
example-name/
├── main.tf                    # Main configuration
├── variables.tf              # Input variables
├── outputs.tf               # Output values
├── terraform.tfvars.example # Example configuration
├── README.md                # Example documentation
├── validate.sh              # Validation script (optional)
└── additional-files/        # Scripts, configs, etc.
```

## 🧩 Module Integration

These examples demonstrate how to combine different modules:

```hcl
# Future example structure
module "vpc" {
  source = "../vpc"
  # vpc configuration
}

module "ec2" {
  source = "../ec2"
  subnet_id = module.vpc.public_subnet_ids[0]
  # ec2 configuration
}
```

## 📚 Learning Path

1. **Start Simple**: Begin with single-module examples (like `ec2-free-tier`)
2. **Add Complexity**: Progress to multi-module examples
3. **Best Practices**: Study the patterns and conventions used
4. **Customize**: Adapt examples to your specific needs

## 🔧 Development

When adding new examples:

1. Follow the consistent file structure
2. Include comprehensive documentation
3. Add validation scripts where helpful
4. Use meaningful variable names and descriptions
5. Include practical, real-world scenarios

## 💡 Tips

- Always use `terraform.tfvars.example` for sensitive variables
- Include validation scripts for complex examples
- Document any prerequisites or special setup requirements
- Test examples in multiple AWS regions when possible

## 🆘 Support

Each example includes:
- Detailed README with step-by-step instructions
- Example configuration files
- Expected outputs and costs
- Cleanup instructions

For issues or questions, check the individual example READMEs first.
