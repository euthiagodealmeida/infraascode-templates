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

module "lab-dynamodb" {
  source = "../../aws/dynamodb"

  table_name                   = var.table_name
  billing_mode                 = var.billing_mode
  hash_key                     = var.hash_key
  range_key                    = var.range_key
  read_capacity                = var.read_capacity
  write_capacity               = var.write_capacity
  enable_point_in_time_recovery = var.enable_point_in_time_recovery
  enable_encryption            = var.enable_encryption
  deletion_protection_enabled  = var.deletion_protection_enabled
  tags                         = var.tags
}
