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

module "lab-alb" {
  source = "../../aws/alb"

  alb_name                   = var.alb_name
  vpc_id                     = var.vpc_id
  subnet_ids                 = var.subnet_ids
  security_group_ids         = var.security_group_ids
  target_group_name          = var.target_group_name
  target_port                = var.target_port
  health_check_path          = var.health_check_path
  health_check_interval      = var.health_check_interval
  health_check_timeout       = var.health_check_timeout
  healthy_threshold          = var.healthy_threshold
  unhealthy_threshold        = var.unhealthy_threshold
  health_check_matcher       = var.health_check_matcher
  ssl_policy                 = var.ssl_policy
  enable_deletion_protection = var.enable_deletion_protection
  certificate_arn            = var.certificate_arn

  tags = var.tags
}