################################################################################
# Add-ons gerenciados do cluster
#
# LIMITAÇÃO DO EMULADOR LOCAL: a API de add-ons não existe no floci —
# `POST /clusters/<nome>/addons` responde UnknownOperationException. Por isso o
# módulo nasce com `habilitar = false` no sandbox: o slot da camada existe, a
# forma do recurso está correta, e contra uma conta real basta ligar a flag.
#
# O mesmo vale, com mais força, para o que exige API do cluster (providers
# kubernetes/helm, malha de serviço, Ingress): o emulador cria o objeto EKS,
# não sobe um control plane. Nada disso é declarado aqui para não fingir
# cobertura que não existe.
################################################################################
locals {
  prefixo = "${var.platform}-${var.application}-${var.env}"
}

resource "aws_eks_addon" "this" {
  for_each = var.habilitar ? var.addons : {}

  cluster_name  = var.cluster_name
  addon_name    = each.key
  addon_version = each.value != "" ? each.value : null

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"

  tags = {
    Name     = "${local.prefixo}-addon-${each.key}"
    resource = "kubernetes"
  }
}
