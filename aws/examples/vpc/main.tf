terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "lab-vpc" {
  source = "../../vpc"

  vpc_name                = var.vpc_name
  vpc_cidr                = var.vpc_cidr
  enable_dns_hostnames    = var.enable_dns_hostnames
  enable_dns_support      = var.enable_dns_support
  availability_zones      = var.availability_zones
  public_subnet_count     = var.public_subnet_count
  private_subnet_count    = var.private_subnet_count
  subnet_cidr_bits        = var.subnet_cidr_bits
  enable_nat_gateway      = var.enable_nat_gateway
  single_nat_gateway      = var.single_nat_gateway
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags                    = var.tags
}
