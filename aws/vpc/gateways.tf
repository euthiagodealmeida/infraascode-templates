resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-igw"
  })
}

# Elastic IPs for NAT Gateway
resource "aws_eip" "nat" {
  count = var.enable_nat_gateway ? (var.single_nat_gateway ? 1 : var.private_subnet_count) : 0

  domain = "vpc"
  depends_on = [aws_internet_gateway.this]

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-nat-eip-${count.index + 1}"
  })
}

# NAT Gateway
resource "aws_nat_gateway" "this" {
  count = var.enable_nat_gateway ? (var.single_nat_gateway ? 1 : var.private_subnet_count) : 0

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  depends_on    = [aws_internet_gateway.this]

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-nat-${count.index + 1}"
  })
}