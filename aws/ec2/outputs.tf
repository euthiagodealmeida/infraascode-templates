output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.this.id
}

output "public_ip" {
  description = "Public IP address"
  value       = aws_instance.this.public_ip
}

output "private_ip" {
  description = "Private IP address"
  value       = aws_instance.this.private_ip
}

output "public_dns" {
  description = "Public DNS name"
  value       = aws_instance.this.public_dns
}

output "security_group_id" {
  description = "Security group ID"
  value       = aws_security_group.ec2_sg.id
}

output "availability_zone" {
  description = "Availability zone"
  value       = aws_instance.this.availability_zone
}

output "subnet_id" {
  description = "Subnet ID where the instance is deployed"
  value       = aws_instance.this.subnet_id
}

output "vpc_id" {
  description = "VPC ID where the instance is deployed"
  value       = data.aws_vpc.default.id
}

output "ami_id" {
  description = "AMI ID used for the instance"
  value       = aws_instance.this.ami
}

output "instance_type" {
  description = "Instance type"
  value       = aws_instance.this.instance_type
}

output "key_name" {
  description = "Key pair name used for SSH access"
  value       = aws_instance.this.key_name
}

output "encrypted" {
  description = "Whether EBS encryption is enabled"
  value       = var.encrypted
}

output "associate_public_ip" {
  description = "Whether public IP is associated"
  value       = var.associate_public_ip
}
