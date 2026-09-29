################################################################################
# Assinatura do tópico de infraestrutura
#
# A policy é do lado da fila: é ela que autoriza o tópico a entregar. Sem esse
# bloco a assinatura é criada e as mensagens somem.
################################################################################
data "aws_iam_policy_document" "fila" {
  statement {
    sid    = "PermitirEntregaDoTopico"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["sns.amazonaws.com"]
    }

    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.trabalho.arn]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [var.sns_infra_arn]
    }
  }
}

resource "aws_sqs_queue_policy" "trabalho" {
  queue_url = aws_sqs_queue.trabalho.id
  policy    = data.aws_iam_policy_document.fila.json
}

resource "aws_sns_topic_subscription" "trabalho" {
  topic_arn = var.sns_infra_arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.trabalho.arn
}
