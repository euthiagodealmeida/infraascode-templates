# AWS VPC Module

A simple, configurable Terraform/OpenTofu module for creating AWS VPCs with public and private subnets, internet gateway, and optional NAT gateway.

## Features

- ✅ **Complete VPC setup**: VPC with DNS support enabled
- ✅ **Auto-calculated subnets**: Uses `cidrsubnet()` to automatically calculate subnet CIDRs
- ✅ **Flexible subnet counts**: Specify how many public/private subnets you need
- ✅ **Multi-AZ distribution**: Automatically distributes subnets across availability zones
- ✅ **Internet Gateway**: Automatic setup for public internet access
- ✅ **Optional NAT Gateway**: For private subnet internet access
- ✅ **Secure defaults**: Locked-down default security group
- ✅ **Consistent tagging**: Apply tags across all resources

## Usage

### Basic VPC (Auto-calculated Subnets)

```hcl
module "vpc" {
  source = "../aws/vpc"

  vpc_name = "my-app-vpc"
  vpc_cidr = "10.0.0.0/16"
  
  # Creates 2 public and 2 private /24 subnets automatically
  public_subnet_count  = 2
  private_subnet_count = 2
  
  tags = {
    Environment = "production"
    Project     = "my-app"
  }
}
```

### VPC with Custom Subnet Sizing

```hcl
module "vpc" {
  source = "../aws/vpc"

  vpc_name = "large-vpc"
  vpc_cidr = "10.0.0.0/16"
  
  public_subnet_count  = 3
  private_subnet_count = 3
  subnet_cidr_bits     = 6  # Creates /22 subnets (1024 IPs each)
  
  tags = {
    Environment = "production"
    Project     = "my-app"
  }
}
```

### Complete VPC with NAT Gateway

```hcl
module "vpc" {
  source = "../aws/vpc"

  vpc_name = "full-vpc"
  vpc_cidr = "10.0.0.0/16"
  
  public_subnet_count  = 2
  private_subnet_count = 2
  
  enable_nat_gateway = true
  single_nat_gateway = true
  
  tags = {
    Environment = "production"
    Project     = "my-app"
  }
}
```

### VPC with Specific Availability Zones

```hcl
module "vpc" {
  source = "../aws/vpc"

  vpc_name = "multi-az-vpc"
  vpc_cidr = "10.0.0.0/16"
  
  availability_zones   = ["us-west-2a", "us-west-2b", "us-west-2c"]
  public_subnet_count  = 3
  private_subnet_count = 3
  
  enable_nat_gateway = true
  single_nat_gateway = false  # One NAT per AZ
  
  tags = {
    Environment = "production"
    HighAvailability = "true"
  }
}
```

## How cidrsubnet() Works

This module uses `cidrsubnet()` function to automatically calculate subnet CIDRs:

```
VPC CIDR: 10.0.0.0/16
subnet_cidr_bits: 8

Public subnets:  10.0.0.0/24, 10.0.1.0/24, 10.0.2.0/24...
Private subnets: 10.0.10.0/24, 10.0.11.0/24, 10.0.12.0/24...
```

**Benefits:**
- **No manual CIDR calculation** needed
- **No overlap conflicts** - subnets are automatically spaced
- **Scalable** - just change the count to add more subnets
- **Consistent** - same pattern across all environments

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vpc_name | Name for the VPC | `string` | `"main-vpc"` | no |
| vpc_cidr | CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |
| enable_dns_hostnames | Enable DNS hostnames in the VPC | `bool` | `true` | no |
| enable_dns_support | Enable DNS support in the VPC | `bool` | `true` | no |
| availability_zones | List of availability zones | `list(string)` | `[]` | no |
| public_subnet_cidrs | CIDR blocks for public subnets | `list(string)` | `["10.0.1.0/24", "10.0.2.0/24"]` | no |
| private_subnet_cidrs | CIDR blocks for private subnets | `list(string)` | `["10.0.10.0/24", "10.0.20.0/24"]` | no |
| enable_nat_gateway | Enable NAT Gateway for private subnets | `bool` | `false` | no |
| single_nat_gateway | Use a single NAT Gateway for all private subnets | `bool` | `true` | no |
| map_public_ip_on_launch | Auto-assign public IP on instance launch in public subnets | `bool` | `true` | no |
| tags | Tags to apply to resources | `map(string)` | `{...}` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | ID of the VPC |
| vpc_arn | ARN of the VPC |
| vpc_cidr_block | CIDR block of the VPC |
| default_security_group_id | ID of the default security group |
| public_subnet_ids | List of IDs of public subnets |
| private_subnet_ids | List of IDs of private subnets |
| public_subnet_cidrs | List of CIDR blocks of public subnets |
| private_subnet_cidrs | List of CIDR blocks of private subnets |
| internet_gateway_id | ID of the Internet Gateway |
| nat_gateway_ids | List of IDs of the NAT Gateways |
| nat_public_ips | List of public Elastic IPs associated with NAT Gateways |
| public_route_table_id | ID of the public route table |
| private_route_table_ids | List of IDs of the private route tables |
| availability_zones | List of availability zones used |

## Architecture

This module creates:

1. **VPC** with configurable CIDR block
2. **Public Subnets** with route to Internet Gateway
3. **Private Subnets** with optional route to NAT Gateway
4. **Internet Gateway** for public internet access
5. **NAT Gateway** (optional) for private subnet internet access
6. **Route Tables** with appropriate routes
7. **Default Security Group** (locked down)

## Cost Considerations

- **NAT Gateway**: Costs ~$45/month per gateway plus data transfer
- **Elastic IPs**: Free when attached to running instances
- **VPC, Subnets, Route Tables, IGW**: Free

Set `enable_nat_gateway = false` for cost-effective development environments.

## Requirements

| Name | Version |
|------|---------|
| opentofu | >= 1.6 |
| aws | >= 5.0 |