################################################################################
# Roles por service account (IRSA)
#
# A condição no `sub` amarra a role a UMA service account de UM namespace.
# Trocar por curinga transforma qualquer pod do cluster em portador da role.
################################################################################
data "aws_iam_policy_document" "irsa" {
  for_each = var.service_accounts

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.cluster.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.issuer_id}:sub"
      values   = ["system:serviceaccount:${each.key}:${each.value}"]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.issuer_id}:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "irsa" {
  for_each = var.service_accounts

  name               = "${local.prefixo}-irsa-${each.value}"
  assume_role_policy = data.aws_iam_policy_document.irsa[each.key].json

  tags = {
    Name     = "${local.prefixo}-irsa-${each.value}"
    resource = "identity"
  }
}
