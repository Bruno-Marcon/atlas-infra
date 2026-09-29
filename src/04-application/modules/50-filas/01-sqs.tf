################################################################################
# Fila de trabalho com dead-letter queue
#
# A DLQ é declarada antes e referenciada pela fila principal: fila sem DLQ
# perde mensagem em silêncio, e é justamente a mensagem que falhou que
# interessa investigar.
################################################################################
locals {
  prefixo = "${var.platform}-${var.application}-${var.env}"
}

resource "aws_sqs_queue" "dlq" {
  name                      = "${local.prefixo}-queue-trabalho-dlq"
  message_retention_seconds = 1209600

  tags = {
    Name     = "${local.prefixo}-queue-trabalho-dlq"
    resource = "queue"
  }
}

resource "aws_sqs_queue" "trabalho" {
  name                       = "${local.prefixo}-queue-trabalho"
  visibility_timeout_seconds = var.fila_config.visibilidade_s
  message_retention_seconds  = var.fila_config.retencao_s

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = var.fila_config.max_tentativas
  })

  tags = {
    Name     = "${local.prefixo}-queue-trabalho"
    resource = "queue"
  }
}
