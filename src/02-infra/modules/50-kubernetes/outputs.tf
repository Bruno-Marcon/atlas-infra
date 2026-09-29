output "cluster_name" {
  description = "Nome do cluster"
  value       = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  description = "Endpoint da API do cluster"
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_ca" {
  description = "Certificado da autoridade do cluster"
  value       = aws_eks_cluster.this.certificate_authority[0].data
  sensitive   = true
}

output "cluster_oidc_issuer" {
  description = "Issuer OIDC — base do IRSA montado na camada 03"
  value       = try(aws_eks_cluster.this.identity[0].oidc[0].issuer, null)
}

output "nodegroup_name" {
  description = "Nome do nodegroup principal"
  value       = aws_eks_node_group.principal.node_group_name
}
