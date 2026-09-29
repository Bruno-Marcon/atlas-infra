################################################################################
# Fila de notificação
#
# O tópico da 00-foundation entrega aqui; quem consome é operação. Assinar por
# fila, e não só por e-mail, é o que permite reprocessar um alerta perdido.
################################################################################
resource "aws_sqs_queue" "notificacao" {
  name                       = "${local.prefixo}-queue-notificacao"
  message_retention_seconds  = 345600
  visibility_timeout_seconds = 60

  tags = {
    Name     = "${local.prefixo}-queue-notificacao"
    resource = "observability"
  }
}

resource "aws_sns_topic_subscription" "notificacao" {
  topic_arn = var.sns_infra_arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.notificacao.arn
}
