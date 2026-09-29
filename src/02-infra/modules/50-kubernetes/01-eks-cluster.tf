################################################################################
# Cluster EKS
#
# A versão vem do ambiente, nunca fixa aqui: é ela que governa o passo do
# upgrade (um minor por vez — ver config.md do workspace).
################################################################################
locals {
  prefixo = "${var.platform}-${var.application}-${var.env}"
}

resource "aws_eks_cluster" "this" {
  name     = "${local.prefixo}-eks"
  role_arn = var.cluster_role_arn
  version  = var.kubernetes_config.versao

  vpc_config {
    subnet_ids              = var.subnet_ids
    security_group_ids      = var.security_group_ids
    endpoint_private_access = true
    endpoint_public_access  = false
  }

  tags = {
    Name     = "${local.prefixo}-eks"
    resource = "kubernetes"
  }
}
