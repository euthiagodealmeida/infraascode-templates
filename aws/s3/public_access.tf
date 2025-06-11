resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = var.enable_public_read ? false : true
  block_public_policy     = var.enable_public_read ? false : true
  ignore_public_acls      = var.enable_public_read ? false : true
  restrict_public_buckets = var.enable_public_read ? false : true
}

resource "aws_s3_bucket_policy" "this" {
  count      = var.enable_public_read ? 1 : 0
  bucket     = aws_s3_bucket.this.id
  depends_on = [aws_s3_bucket_public_access_block.this]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.this.arn}/*"
      }
    ]
  })
}