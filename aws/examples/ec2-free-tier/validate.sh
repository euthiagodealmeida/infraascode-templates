#!/bin/bash

set -e

echo "🔍 Validating EC2 from lab-ec2..."

cd "$(dirname "$0")"

echo "📁 Current directory: $(pwd)"

echo "✅ Checking required files..."
required_files=(
    "main.tf"
    "variables.tf" 
    "outputs.tf"
    "user-data.sh"
    "terraform.tfvars.example"
    "README.md"
)

for file in "${required_files[@]}"; do
    if [[ -f "$file" ]]; then
        echo "  ✓ $file exists"
    else
        echo "  ❌ $file is missing"
        exit 1
    fi
done

echo "🔧 Validating Terraform syntax..."
if command -v tofu &> /dev/null; then
    tofu fmt -check=true -diff=true
    echo "  ✓ OpenTofu formatting is correct"
    
    tofu init -backend=false > /dev/null 2>&1
    tofu validate
    echo "  ✓ OpenTofu configuration is valid"
elif command -v terraform &> /dev/null; then
    terraform fmt -check=true -diff=true
    echo "  ✓ Terraform formatting is correct"
    
    terraform init -backend=false > /dev/null 2>&1
    terraform validate
    echo "  ✓ Terraform configuration is valid"
else
    echo "  ⚠️  Neither tofu nor terraform found, skipping validation"
fi

echo "🔧 Validating user-data script..."
if bash -n user-data.sh; then
    echo "  ✓ user-data.sh syntax is valid"
else
    echo "  ❌ user-data.sh has syntax errors"
    exit 1
fi

echo ""
echo "🎉 All validations passed!"
echo ""
echo "📖 To deploy this example:"
echo "   1. cp terraform.tfvars.example terraform.tfvars"
echo "   2. Edit terraform.tfvars with your key pair name"
echo "   3. tofu init && tofu apply"
