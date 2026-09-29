output "oidc_provider_arn" {
  description = "ARN do provedor OIDC do cluster"
  value       = aws_iam_openid_connect_provider.cluster.arn
}

output "irsa_role_arns" {
  description = "Role de cada service account (namespace => ARN)"
  value       = { for k, v in aws_iam_role.irsa : k => v.arn }
}
