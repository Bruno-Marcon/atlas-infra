################################################################################
# Log groups
#
# Retenção nunca fica infinita: log sem prazo é custo que ninguém revisa.
# O valor vem do ambiente, em env/<ambiente>/variables.tfvars.
################################################################################
locals {
  prefixo = "${var.platform}-${var.application}-${var.env}"
}

resource "aws_cloudwatch_log_group" "app" {
  name              = "/${var.platform}/${var.application}/${var.env}/app"
  retention_in_days = var.log_retencao_dias

  tags = {
    Name     = "${local.prefixo}-log-app"
    resource = "observability"
  }
}

resource "aws_cloudwatch_log_group" "auditoria" {
  name              = "/${var.platform}/${var.application}/${var.env}/auditoria"
  retention_in_days = var.log_retencao_dias

  tags = {
    Name     = "${local.prefixo}-log-auditoria"
    resource = "observability"
  }
}
