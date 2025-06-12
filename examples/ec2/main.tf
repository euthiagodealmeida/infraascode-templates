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
  source = "../../aws/ec2"

  name               = var.instance_name
  instance_type      = var.instance_type
  key_name           = var.key_name
  associate_public_ip = var.associate_public_ip
  volume_size        = var.volume_size
  encrypted          = var.encrypted

  user_data = base64encode(templatefile("${path.module}/user-data.sh", {
    server_name = var.instance_name
  }))

  tags = var.tags
}
