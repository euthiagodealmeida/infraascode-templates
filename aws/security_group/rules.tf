resource "aws_security_group_rule" "ingress" {
  count = length(var.ingress_rules)

  type              = "ingress"
  security_group_id = aws_security_group.this.id

  from_port   = var.ingress_rules[count.index].from_port
  to_port     = var.ingress_rules[count.index].to_port
  protocol    = var.ingress_rules[count.index].protocol
  description = lookup(var.ingress_rules[count.index], "description", null)

  cidr_blocks              = lookup(var.ingress_rules[count.index], "cidr_blocks", null)
  ipv6_cidr_blocks         = lookup(var.ingress_rules[count.index], "ipv6_cidr_blocks", null)
  prefix_list_ids          = lookup(var.ingress_rules[count.index], "prefix_list_ids", null)
  source_security_group_id = lookup(var.ingress_rules[count.index], "source_security_group_id", null)
  self                     = lookup(var.ingress_rules[count.index], "self", null)
}

resource "aws_security_group_rule" "egress" {
  count = length(var.egress_rules)

  type              = "egress"
  security_group_id = aws_security_group.this.id

  from_port   = var.egress_rules[count.index].from_port
  to_port     = var.egress_rules[count.index].to_port
  protocol    = var.egress_rules[count.index].protocol
  description = lookup(var.egress_rules[count.index], "description", null)

  cidr_blocks              = lookup(var.egress_rules[count.index], "cidr_blocks", null)
  ipv6_cidr_blocks         = lookup(var.egress_rules[count.index], "ipv6_cidr_blocks", null)
  prefix_list_ids          = lookup(var.egress_rules[count.index], "prefix_list_ids", null)
  source_security_group_id = lookup(var.egress_rules[count.index], "source_security_group_id", null)
  self                     = lookup(var.egress_rules[count.index], "self", null)
}

# Common rules for HTTP, HTTPS, and SSH access
resource "aws_security_group_rule" "http" {
  count = var.allow_http_from_cidr != null ? 1 : 0

  type              = "ingress"
  security_group_id = aws_security_group.this.id
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.allow_http_from_cidr
  description       = "HTTP access"
}

resource "aws_security_group_rule" "https" {
  count = var.allow_https_from_cidr != null ? 1 : 0

  type              = "ingress"
  security_group_id = aws_security_group.this.id
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.allow_https_from_cidr
  description       = "HTTPS access"
}

resource "aws_security_group_rule" "ssh" {
  count = var.allow_ssh_from_cidr != null ? 1 : 0

  type              = "ingress"
  security_group_id = aws_security_group.this.id
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.allow_ssh_from_cidr
  description       = "SSH access"
}

# Common egress rule to allow all outbound traffic
resource "aws_security_group_rule" "default_egress" {
  count = var.allow_all_outbound ? 1 : 0

  type              = "egress"
  security_group_id = aws_security_group.this.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "All outbound traffic"
}
