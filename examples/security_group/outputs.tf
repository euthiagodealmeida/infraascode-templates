output "security_group_id" {
  description = "ID of the security group"
  value       = module.lab-security-group.security_group_id
}

output "security_group_arn" {
  description = "ARN of the security group"
  value       = module.lab-security-group.security_group_arn
}

output "security_group_name" {
  description = "Name of the security group"
  value       = module.lab-security-group.security_group_name
}

output "security_group_description" {
  description = "Description of the security group"
  value       = module.lab-security-group.security_group_description
}

output "security_group_vpc_id" {
  description = "VPC ID of the security group"
  value       = module.lab-security-group.security_group_vpc_id
}

output "ingress_rule_ids" {
  description = "IDs of the ingress rules"
  value       = module.lab-security-group.ingress_rule_ids
}

output "egress_rule_ids" {
  description = "IDs of the egress rules"
  value       = module.lab-security-group.egress_rule_ids
}
