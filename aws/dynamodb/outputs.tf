output "table_name" {
  description = "The name of the DynamoDB table"
  value       = aws_dynamodb_table.this.name
}

output "table_id" {
  description = "The ID of the DynamoDB table"
  value       = aws_dynamodb_table.this.id
}

output "table_arn" {
  description = "The ARN of the DynamoDB table"
  value       = aws_dynamodb_table.this.arn
}

output "hash_key" {
  description = "The hash (partition) key of the table"
  value       = aws_dynamodb_table.this.hash_key
}

output "range_key" {
  description = "The range (sort) key of the table"
  value       = aws_dynamodb_table.this.range_key
}

output "billing_mode" {
  description = "The billing mode of the table"
  value       = aws_dynamodb_table.this.billing_mode
}

output "point_in_time_recovery_enabled" {
  description = "Whether point-in-time recovery is enabled"
  value       = aws_dynamodb_table.this.point_in_time_recovery[0].enabled
}

output "server_side_encryption_enabled" {
  description = "Whether server-side encryption is enabled"
  value       = aws_dynamodb_table.this.server_side_encryption[0].enabled
}
