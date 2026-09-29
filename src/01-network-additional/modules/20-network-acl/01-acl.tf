################################################################################
# Network ACL das subnets públicas
################################################################################
locals {
  prefixo = "${var.platform}-${var.application}-${var.env}"
}

resource "aws_network_acl" "public" {
  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  tags = {
    Name     = "${local.prefixo}-acl-public"
    resource = "network"
  }
}

resource "aws_network_acl_rule" "entrada_https" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.cidr_permitido_interno
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "saida_toda" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}
