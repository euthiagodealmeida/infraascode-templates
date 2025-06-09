resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.this.id

  ingress = []
  egress = []

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-default-sg"
  })
}