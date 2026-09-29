################################################################################
# Security groups
################################################################################
resource "aws_security_group" "app" {
  name        = "${local.prefixo}-sg-app"
  description = "Trafego da aplicacao"
  vpc_id      = aws_vpc.this.id

  tags = {
    Name     = "${local.prefixo}-sg-app"
    resource = "network"
  }
}

resource "aws_vpc_security_group_ingress_rule" "app_https" {
  security_group_id = aws_security_group.app.id
  description       = "HTTPS de dentro da VPC"
  cidr_ipv4         = aws_vpc.this.cidr_block
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "app_all" {
  security_group_id = aws_security_group.app.id
  description       = "Saida liberada"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
