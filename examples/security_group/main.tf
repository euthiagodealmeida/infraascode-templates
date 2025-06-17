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

module "lab-security-group" {
  source = "../../aws/security_group"

  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  # Some default and common configurations
  allow_http_from_cidr  = var.allow_http_from_cidr
  allow_https_from_cidr = var.allow_https_from_cidr
  allow_ssh_from_cidr   = var.allow_ssh_from_cidr
  allow_all_outbound    = var.allow_all_outbound

  # Rules
  ingress_rules = var.ingress_rules
  egress_rules = var.egress_rules

  tags = var.tags
}
