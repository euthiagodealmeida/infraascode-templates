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

module "lab-ec2" {
  source = "../../ec2"

  name          = var.instance_name
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = base64encode(templatefile("${path.module}/user-data.sh", {
    server_name = var.instance_name
  }))

  tags = var.tags
}
