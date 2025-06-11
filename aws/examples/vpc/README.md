# Basic VPC Example

This example demonstrates how to create a basic VPC with public and private subnets using the VPC module.

## 🌟 What it creates

- ✅ VPC with configurable CIDR block
- ✅ Public subnets with auto-assigned public IPs
- ✅ Private subnets (no direct internet access)
- ✅ Internet Gateway for public subnet connectivity
- ✅ Automatic subnet CIDR calculation using `cidrsubnet()`
- ✅ Multi-AZ distribution for high availability
- ✅ Secure default security group (locked down)

## 🚀 Quick Start

1. **Copy the example configuration:**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. **Edit `terraform.tfvars` with your values:**
   ```hcl
   vpc_name = "my-awesome-vpc"
   vpc_cidr = "10.0.0.0/16"
   public_subnet_count = 2
   private_subnet_count = 2
   ```

3. **Deploy your VPC:**
   ```bash
   tofu init
   tofu plan
   tofu apply
   ```

4. **View the results:**
   ```bash
   # Get VPC details
   tofu output vpc_summary
   
   # Get calculated subnet CIDRs
   tofu output calculated_public_cidrs
   tofu output calculated_private_cidrs
   ```

## 📊 Outputs

After deployment, you'll get these useful outputs:

- `vpc_id`: The VPC identifier
- `vpc_cidr_block`: The VPC CIDR block
- `public_subnet_ids`: List of public subnet IDs
- `private_subnet_ids`: List of private subnet IDs
- `public_subnet_cidrs`: List of public subnet CIDR blocks
- `private_subnet_cidrs`: List of private subnet CIDR blocks
- `internet_gateway_id`: Internet Gateway ID
- `availability_zones`: AZs used for subnet distribution
- `calculated_public_cidrs`: Auto-calculated public subnet CIDRs
- `calculated_private_cidrs`: Auto-calculated private subnet CIDRs
- `vpc_summary`: Complete summary with all key information

## 🎨 Features

This example showcases:
- **Auto-calculated subnets**: Uses `cidrsubnet()` to automatically calculate subnet CIDRs
- **Multi-AZ distribution**: Distributes subnets across availability zones
- **Flexible configuration**: Easy to adjust subnet counts and CIDR sizing
- **Cost-optimized defaults**: NAT Gateway disabled by default for lab environments

## 💰 Cost

This example uses cost-effective defaults:
- VPC, subnets, route tables, and Internet Gateway: **Free**
- NAT Gateway: **Disabled by default** (saves ~$45/month)
- Only enable NAT Gateway if private subnets need internet access

## 🔧 Customization

### Add NAT Gateway for Private Subnet Internet Access

```hcl
enable_nat_gateway = true
single_nat_gateway = true  # Use one NAT for all private subnets (cost-effective)
```

### Create More Subnets

```hcl
public_subnet_count  = 3
private_subnet_count = 3
```

### Use Larger Subnets

```hcl
subnet_cidr_bits = 6  # Creates /22 subnets (1024 IPs each) instead of /24
```

### Specify Availability Zones

```hcl
availability_zones = ["sa-east-1a", "sa-east-1b"]
```

## 🧪 Testing

After deployment, verify your VPC:

1. **Check VPC in AWS Console**: Go to VPC → Your VPCs
2. **Verify subnets**: Check that subnets are in different AZs
3. **Test connectivity**: Launch an EC2 instance in a public subnet

## 🧹 Clean Up

```bash
tofu destroy
```

## 📁 File Structure

```
vpc-basic/
├── main.tf                    # Main configuration
├── variables.tf              # Input variables
├── outputs.tf               # Output values
├── terraform.tfvars.example # Example configuration
└── README.md               # This file
```

## 🔗 Integration

This VPC can be used with other modules:

```hcl
# Use this VPC with EC2 module
module "vpc" {
  source = "../../vpc"
  # ... vpc configuration
}

module "web_server" {
  source = "../../ec2"
  
  subnet_id = module.vpc.public_subnet_ids[0]
  vpc_id    = module.vpc.vpc_id
}
```
