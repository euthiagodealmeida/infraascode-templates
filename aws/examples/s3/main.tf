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

  bucket_name        = var.bucket_name
  force_destroy      = var.force_destroy
  enable_versioning  = var.enable_versioning
  kms_key_id         = var.kms_key_id
  bucket_key_enabled = var.bucket_key_enabled
  enable_public_read = var.enable_public_read
  website_config     = var.website_config
  tags               = var.tags
}
