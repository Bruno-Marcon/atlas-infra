################################################################################
# SNS Topic — canal único de notificação de infraestrutura do ambiente
################################################################################
locals {
  prefixo = "${var.platform}-${var.application}-${var.env}"
}

resource "aws_sns_topic" "infra" {
  name = "${local.prefixo}-sns-infra"

  tags = {
    Name     = "${local.prefixo}-sns-infra"
    resource = "notification"
  }
}

resource "aws_sns_topic_subscription" "infra_email" {
  topic_arn = aws_sns_topic.infra.arn
  protocol  = "email"
  endpoint  = var.notificacao_email
}
