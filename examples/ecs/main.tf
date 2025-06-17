terraform {
  required_version = ">= 1.8.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.100"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "ecs_cluster" {
  source = "../../aws/ecs"

  cluster_name                        = var.cluster_name
  capacity_providers                  = var.capacity_providers
  default_capacity_provider_strategy  = var.default_capacity_provider_strategy
  enable_container_insights           = var.enable_container_insights
  enable_execute_command              = var.enable_execute_command

  tags = var.tags
}
