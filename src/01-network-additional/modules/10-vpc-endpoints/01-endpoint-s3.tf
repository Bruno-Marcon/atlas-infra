################################################################################
# Gateway endpoint de S3
#
# Mantido nesta camada, e não na 00, porque endpoint é acréscimo de rede:
# some e volta sem recriar a VPC.
################################################################################
locals {
  prefixo = "${var.platform}-${var.application}-${var.env}"
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [var.route_table_public_id]

  tags = {
    Name     = "${local.prefixo}-vpce-s3"
    resource = "network"
  }
}
