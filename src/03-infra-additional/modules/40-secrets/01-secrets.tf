################################################################################
# Segredo da aplicação
#
# O Terraform cria o CONTÊINER do segredo e quem pode lê-lo; o VALOR nunca vem
# do código nem do tfvars. Ele é escrito fora do ciclo (rotação, pipeline ou à
# mão) e o `ignore_changes` impede que um apply futuro o sobrescreva.
################################################################################
locals {
  prefixo = "${var.platform}-${var.application}-${var.env}"
}

resource "aws_secretsmanager_secret" "app" {
  name        = "${local.prefixo}-secret-app"
  description = "Credenciais da aplicacao ${var.application} em ${var.env}"

  tags = {
    Name     = "${local.prefixo}-secret-app"
    resource = "secret"
  }
}

resource "aws_secretsmanager_secret_version" "app_placeholder" {
  secret_id     = aws_secretsmanager_secret.app.id
  secret_string = jsonencode({ preenchido_fora_do_terraform = true })

  lifecycle {
    ignore_changes = [secret_string]
  }
}

data "aws_iam_policy_document" "leitura" {
  statement {
    sid    = "LeituraPelaRoleDaAplicacao"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [var.app_role_arn]
    }

    actions   = ["secretsmanager:GetSecretValue"]
    resources = ["*"]
  }
}

resource "aws_secretsmanager_secret_policy" "app" {
  secret_arn = aws_secretsmanager_secret.app.arn
  policy     = data.aws_iam_policy_document.leitura.json
}
