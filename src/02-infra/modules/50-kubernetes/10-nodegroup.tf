################################################################################
# Nodegroup
#
# min/max/desired vêm do ambiente. É esse trio que permite o ambiente de
# desenvolvimento zerar fora do horário sem tocar no código da camada.
################################################################################
resource "aws_eks_node_group" "principal" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${local.prefixo}-ng-principal"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  instance_types = var.kubernetes_config.instance_types
  capacity_type  = var.kubernetes_config.capacity_type

  scaling_config {
    min_size     = var.kubernetes_config.min_size
    max_size     = var.kubernetes_config.max_size
    desired_size = var.kubernetes_config.desired_size
  }

  update_config {
    max_unavailable = 1
  }

  lifecycle {
    # desired_size muda por autoscaling; o Terraform não deve brigar com isso
    ignore_changes = [scaling_config[0].desired_size]
  }

  tags = {
    Name     = "${local.prefixo}-ng-principal"
    resource = "kubernetes"
  }
}
