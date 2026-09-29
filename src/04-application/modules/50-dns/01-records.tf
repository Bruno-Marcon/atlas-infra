################################################################################
# Registros DNS da aplicação
#
# O alvo padrão é o endpoint do cluster; um alvo explícito no tfvars vence.
# A zona é privada, então esses nomes só resolvem de dentro da VPC — que é o
# comportamento desejado para ambiente que não deve ser alcançável de fora.
################################################################################
locals {
  prefixo      = "${var.platform}-${var.application}-${var.env}"
  host_cluster = replace(replace(var.cluster_endpoint, "https://", ""), "/", "")
}

resource "aws_route53_record" "app" {
  for_each = var.registros

  zone_id = var.zone_id
  name    = "${each.key}.${var.zone_name}"
  type    = "CNAME"
  ttl     = 300
  records = [each.value != "" ? each.value : local.host_cluster]
}
