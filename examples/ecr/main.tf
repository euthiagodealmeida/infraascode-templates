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

module "lab-ecr" {
  source = "../../aws/ecr"

  repository_name      = var.repository_name
  image_tag_mutability = var.image_tag_mutability
  force_delete         = var.force_delete
  scan_on_push         = var.scan_on_push
  encryption_type      = var.encryption_type
  kms_key_id           = var.kms_key_id
  enable_lifecycle_policy = var.enable_lifecycle_policy
  tags                 = var.tags
}
