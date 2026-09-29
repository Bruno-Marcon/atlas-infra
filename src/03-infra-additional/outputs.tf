################################################################################
# Identidade do cluster
################################################################################
output "oidc_provider_arn" {
  description = "Provedor OIDC do cluster"
  value       = module.k8s-oidc.oidc_provider_arn
}

output "irsa_role_arns" {
  description = "Roles por service account"
  value       = module.k8s-oidc.irsa_role_arns
}

################################################################################
# Observabilidade
################################################################################
output "log_group_app_name" {
  description = "Log group da aplicação"
  value       = module.observabilidade.log_group_name
}

output "queue_notificacao_arn" {
  description = "Fila assinante do tópico de infraestrutura"
  value       = module.observabilidade.queue_notificacao_arn
}

################################################################################
# Segredos e TLS
################################################################################
output "secret_app_arn" {
  description = "Segredo da aplicação — consumido pela camada 04"
  value       = module.secrets.secret_arn
}

output "parametros_paths" {
  description = "Caminhos publicados no parameter store"
  value       = module.secrets.parametros_paths
}

output "certificado_arn" {
  description = "Certificado TLS do ambiente — consumido pela camada 04"
  value       = module.tls-certificados.certificado_arn
}

output "addons_instalados" {
  description = "Add-ons do cluster efetivamente criados"
  value       = module.k8s-addons.addons_instalados
}
