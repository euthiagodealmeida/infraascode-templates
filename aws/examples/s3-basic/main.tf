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

module "lab-s3" {
  source = "../../s3"

  bucket_name                = var.bucket_name
  force_destroy             = var.force_destroy
  versioning_status         = var.versioning_status
  sse_algorithm             = var.sse_algorithm
  kms_key_id               = var.kms_key_id
  bucket_key_enabled       = var.bucket_key_enabled
  block_public_acls        = var.block_public_acls
  block_public_policy      = var.block_public_policy
  ignore_public_acls       = var.ignore_public_acls
  restrict_public_buckets  = var.restrict_public_buckets
  bucket_policy_count      = var.bucket_policy_count
  public_read_policy       = var.public_read_policy
  website_config_count     = var.website_config_count
  website_index_document   = var.website_index_document
  website_error_document   = var.website_error_document
  website_endpoint         = var.website_endpoint
  website_domain          = var.website_domain
  tags                    = var.tags
}
