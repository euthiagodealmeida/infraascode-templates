locals {
  # Get AZs - use specified ones or auto-detect
  availability_zones = length(var.availability_zones) > 0 ? var.availability_zones : slice(data.aws_availability_zones.available.names, 0, max(var.public_subnet_count, var.private_subnet_count))
  
  # Calculate public subnet CIDRs
  public_subnet_cidrs = [
    for i in range(var.public_subnet_count) : 
    cidrsubnet(var.vpc_cidr, var.subnet_cidr_bits, i)
  ]
  
  # Calculate private subnet CIDRs (offset by 10 to avoid overlap)
  private_subnet_cidrs = [
    for i in range(var.private_subnet_count) : 
    cidrsubnet(var.vpc_cidr, var.subnet_cidr_bits, i + 10)
  ]
}
