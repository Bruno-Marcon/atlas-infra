################################################################################
# Roles do EKS — control plane e nós
#
# São duas identidades distintas de propósito: o control plane gerencia ENI e
# balanceador; o nó registra a instância e puxa imagem. Juntar as duas numa role
# só é o atalho que vira achado de auditoria depois.
################################################################################
data "aws_iam_policy_document" "assume_eks_cluster" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "assume_eks_node" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_cluster" {
  count = var.habilitar_roles_eks ? 1 : 0

  name               = "${local.prefixo}-role-eks-cluster"
  assume_role_policy = data.aws_iam_policy_document.assume_eks_cluster.json

  tags = {
    Name     = "${local.prefixo}-role-eks-cluster"
    resource = "identity"
  }
}

resource "aws_iam_role" "eks_node" {
  count = var.habilitar_roles_eks ? 1 : 0

  name               = "${local.prefixo}-role-eks-node"
  assume_role_policy = data.aws_iam_policy_document.assume_eks_node.json

  tags = {
    Name     = "${local.prefixo}-role-eks-node"
    resource = "identity"
  }
}

locals {
  policies_cluster = var.habilitar_roles_eks ? [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
  ] : []

  policies_node = var.habilitar_roles_eks ? [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
  ] : []
}

resource "aws_iam_role_policy_attachment" "eks_cluster" {
  for_each = toset(local.policies_cluster)

  role       = aws_iam_role.eks_cluster[0].name
  policy_arn = each.value
}

resource "aws_iam_role_policy_attachment" "eks_node" {
  for_each = toset(local.policies_node)

  role       = aws_iam_role.eks_node[0].name
  policy_arn = each.value
}
