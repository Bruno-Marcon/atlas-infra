################################################################################
# Zona DNS privada do ambiente
#
# Numerada antes do IAM (09) de propósito: cluster, banco e certificado
# publicam nome aqui, então a zona precisa existir antes deles.
################################################################################
locals {
  prefixo = "${var.platform}-${var.application}-${var.env}"
}

resource "aws_route53_zone" "privada" {
  name    = var.dominio
  comment = "Zona privada de ${var.application} em ${var.env}"

  vpc {
    vpc_id = var.vpc_id
  }

  tags = {
    Name     = "${local.prefixo}-zone"
    resource = "dns"
  }
}
