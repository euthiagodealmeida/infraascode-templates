# AWS Managed
resource "aws_iam_role_policy_attachment" "aws_managed" {
  for_each = toset(var.aws_managed_policy_arns)

  role       = aws_iam_role.this.name
  policy_arn = each.value
}

# Customer Managed
resource "aws_iam_role_policy_attachment" "customer_managed" {
  for_each = toset(var.customer_managed_policy_arns)

  role       = aws_iam_role.this.name
  policy_arn = each.value
}

# Inline Policies
resource "aws_iam_role_policy" "inline" {
  for_each = var.inline_policies

  name   = each.key
  role   = aws_iam_role.this.id
  policy = each.value.policy
}
