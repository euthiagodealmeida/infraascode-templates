output "vpc_id" {
  description = "ID of the VPC"
  value       = module.lab-vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = module.lab-vpc.vpc_cidr_block
}

output "public_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = module.lab-vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of IDs of private subnets"
  value       = module.lab-vpc.private_subnet_ids
}

output "public_subnet_cidrs" {
  description = "List of CIDR blocks of public subnets"
  value       = module.lab-vpc.public_subnet_cidrs
}

output "private_subnet_cidrs" {
  description = "List of CIDR blocks of private subnets"
  value       = module.lab-vpc.private_subnet_cidrs
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = module.lab-vpc.internet_gateway_id
}

output "availability_zones" {
  description = "List of availability zones used"
  value       = module.lab-vpc.availability_zones
}

output "calculated_public_cidrs" {
  description = "Auto-calculated CIDR blocks for public subnets"
  value       = module.lab-vpc.calculated_public_cidrs
}

output "calculated_private_cidrs" {
  description = "Auto-calculated CIDR blocks for private subnets"
  value       = module.lab-vpc.calculated_private_cidrs
}

output "vpc_summary" {
  description = "Summary of the created VPC"
  value = {
    name              = var.vpc_name
    cidr              = module.lab-vpc.vpc_cidr_block
    region            = var.aws_region
    availability_zones = module.lab-vpc.availability_zones
    public_subnets    = length(module.lab-vpc.public_subnet_ids)
    private_subnets   = length(module.lab-vpc.private_subnet_ids)
    nat_gateway       = var.enable_nat_gateway
  }
}
