output "table_name" {
  description = "The name of the DynamoDB table"
  value       = module.lab-dynamodb.table_name
}

output "table_id" {
  description = "The ID of the DynamoDB table"
  value       = module.lab-dynamodb.table_id
}

output "table_arn" {
  description = "The ARN of the DynamoDB table"
  value       = module.lab-dynamodb.table_arn
}

output "hash_key" {
  description = "The hash (partition) key of the table"
  value       = module.lab-dynamodb.hash_key
}

output "range_key" {
  description = "The range (sort) key of the table"
  value       = module.lab-dynamodb.range_key
}

output "billing_mode" {
  description = "The billing mode of the table"
  value       = module.lab-dynamodb.billing_mode
}

output "point_in_time_recovery_enabled" {
  description = "Whether point-in-time recovery is enabled"
  value       = module.lab-dynamodb.point_in_time_recovery_enabled
}

output "server_side_encryption_enabled" {
  description = "Whether server-side encryption is enabled"
  value       = module.lab-dynamodb.server_side_encryption_enabled
}

output "table_summary" {
  description = "Summary of the created DynamoDB table"
  value = {
    name              = var.table_name
    region            = var.aws_region
    billing_mode      = var.billing_mode
    hash_key          = var.hash_key
    range_key         = var.range_key
    encryption        = var.enable_encryption
    pitr_enabled      = var.enable_point_in_time_recovery
    deletion_protection = var.deletion_protection_enabled
  }
}
