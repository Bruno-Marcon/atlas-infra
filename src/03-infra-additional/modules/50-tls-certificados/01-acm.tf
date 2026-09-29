################################################################################
# Certificado TLS
#
# Validação por DNS, com o registro publicado na própria zona do ambiente.
# Não há `aws_acm_certificate_validation` de propósito: esse recurso BLOQUEIA
# o apply esperando a emissão, o que nunca acontece numa zona privada.
################################################################################
locals {
  prefixo = "${var.platform}-${var.application}-${var.env}"
}

resource "aws_acm_certificate" "app" {
  domain_name               = var.dominio
  subject_alternative_names = ["*.${var.dominio}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name     = "${local.prefixo}-cert"
    resource = "tls"
  }
}

resource "aws_route53_record" "validacao" {
  for_each = {
    for dvo in aws_acm_certificate.app.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id         = var.zone_id
  name            = each.value.name
  type            = each.value.type
  records         = [each.value.record]
  ttl             = 60
  allow_overwrite = true
}
