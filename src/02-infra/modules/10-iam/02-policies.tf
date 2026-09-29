################################################################################
# Policy da aplicação — menor privilégio, escopo fechado por ARN
#
# Nada de Resource "*": o bucket de auditoria vem por variável justamente para
# que a policy nasça amarrada ao recurso real da camada anterior.
################################################################################
data "aws_iam_policy_document" "app" {
  statement {
    sid    = "EscritaDeAuditoria"
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:GetObject",
    ]

    resources = ["arn:aws:s3:::${var.audit_bucket_id}/*"]
  }

  statement {
    sid    = "LeituraDeParametros"
    effect = "Allow"

    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:GetParametersByPath",
    ]

    resources = ["arn:aws:ssm:*:*:parameter/${var.platform}/${var.application}/${var.env}/*"]
  }
}

resource "aws_iam_policy" "app" {
  name        = "${local.prefixo}-policy-app"
  description = "Permissoes da aplicacao ${var.application} em ${var.env}"
  policy      = data.aws_iam_policy_document.app.json
}

resource "aws_iam_role_policy_attachment" "app" {
  role       = aws_iam_role.app.name
  policy_arn = aws_iam_policy.app.arn
}
