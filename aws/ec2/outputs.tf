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
