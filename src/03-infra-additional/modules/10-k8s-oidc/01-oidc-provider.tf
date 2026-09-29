################################################################################
# Provedor OIDC do cluster
#
# É o que habilita IRSA: pod assume role da nuvem pela service account, sem
# chave estática dentro do contêiner. Sem este provider, a alternativa vira
# secret de acesso no cluster — que é exatamente o que se quer evitar.
################################################################################
locals {
  prefixo   = "${var.platform}-${var.application}-${var.env}"
  issuer    = var.cluster_oidc_issuer
  issuer_id = replace(var.cluster_oidc_issuer, "https://", "")
}

resource "aws_iam_openid_connect_provider" "cluster" {
  url             = local.issuer
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]

  tags = {
    Name     = "${local.prefixo}-oidc"
    resource = "identity"
  }
}
