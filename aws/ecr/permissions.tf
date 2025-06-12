data "aws_iam_policy_document" "ecr_repository_policy" {
  count = var.enable_repository_policy ? 1 : 0

  statement {
    sid    = "AllowPushPull"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = var.allowed_principals
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeRepositories",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:DescribeImages"
    ]
  }
}

resource "aws_ecr_repository_policy" "this" {
  count      = var.enable_repository_policy ? 1 : 0
  repository = aws_ecr_repository.this.name

  policy = var.repository_policy != null ? var.repository_policy : data.aws_iam_policy_document.ecr_repository_policy[0].json
}