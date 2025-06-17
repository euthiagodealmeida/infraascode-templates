output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.this.id
}

output "security_group_arn" {
  description = "ARN of the security group"
  value       = aws_security_group.this.arn
}

output "security_group_name" {
  description = "Name of the security group"
  value       = aws_security_group.this.name
}

output "security_group_description" {
  description = "Description of the security group"
  value       = aws_security_group.this.description
}

output "security_group_vpc_id" {
  description = "VPC ID of the security group"
  value       = aws_security_group.this.vpc_id
}

output "security_group_owner_id" {
  description = "Owner ID of the security group"
  value       = aws_security_group.this.owner_id
}

output "ingress_rule_ids" {
  description = "IDs of the ingress rules"
  value       = aws_security_group_rule.ingress[*].id
}

output "egress_rule_ids" {
  description = "IDs of the egress rules"
  value       = aws_security_group_rule.egress[*].id
}
