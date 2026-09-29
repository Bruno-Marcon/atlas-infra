output "role_arn" {
  description = "ARN da role da aplicação"
  value       = aws_iam_role.app.arn
}

output "role_name" {
  description = "Nome da role da aplicação"
  value       = aws_iam_role.app.name
}

output "policy_arn" {
  description = "ARN da policy da aplicação"
  value       = aws_iam_policy.app.arn
}

output "eks_cluster_role_arn" {
  description = "Role do control plane do EKS"
  value       = var.habilitar_roles_eks ? aws_iam_role.eks_cluster[0].arn : null
}

output "eks_node_role_arn" {
  description = "Role dos nós do EKS"
  value       = var.habilitar_roles_eks ? aws_iam_role.eks_node[0].arn : null
}
