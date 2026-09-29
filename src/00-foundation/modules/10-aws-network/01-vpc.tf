################################################################################
# VPC
################################################################################
locals {
  prefixo  = "${var.platform}-${var.application}-${var.env}"
  vpc_cidr = "${var.cidr_subnet}.0.0/16"
}

resource "aws_vpc" "this" {
  cidr_block           = local.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name     = "${local.prefixo}-vpc"
    resource = "network"
  }
}
