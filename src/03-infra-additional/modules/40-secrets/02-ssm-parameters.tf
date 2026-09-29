################################################################################
# Parameter Store — configuração não-sensível
#
# O caminho segue /<platform>/<application>/<env>/<chave>, que é exatamente o
# escopo liberado na policy da camada 02-infra.
################################################################################
resource "aws_ssm_parameter" "aplicacao" {
  for_each = var.parametros_aplicacao

  name  = "/${var.platform}/${var.application}/${var.env}/${each.key}"
  type  = "String"
  value = each.value

  tags = {
    Name     = "${local.prefixo}-param-${each.key}"
    resource = "config"
  }
}
