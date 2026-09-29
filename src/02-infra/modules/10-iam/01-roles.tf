################################################################################
# Role da aplicação
################################################################################
locals {
  prefixo = "${var.platform}-${var.application}-${var.env}"
}

data "aws_iam_policy_document" "assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "app" {
  name               = "${local.prefixo}-role-app"
  assume_role_policy = data.aws_iam_policy_document.assume.json

  tags = {
    Name     = "${local.prefixo}-role-app"
    resource = "identity"
  }
}
