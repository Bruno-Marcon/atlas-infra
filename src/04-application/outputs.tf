output "bucket_app_id" {
  description = "Bucket da aplicação"
  value       = module.storages.bucket_id
}

output "fila_trabalho_url" {
  description = "URL da fila de trabalho"
  value       = module.filas.fila_url
}

output "fila_dlq_url" {
  description = "URL da dead-letter queue"
  value       = module.filas.dlq_url
}

output "secret_app_arn" {
  description = "Segredo consumido pela aplicação, vindo da camada 03"
  value       = data.terraform_remote_state.infra_additional.outputs.secret_app_arn
}

output "registros_dns" {
  description = "Nomes publicados na zona do ambiente"
  value       = module.dns.registros_publicados
}

output "certificado_arn" {
  description = "Certificado TLS herdado da camada 03"
  value       = data.terraform_remote_state.infra_additional.outputs.certificado_arn
}

output "db_endpoint" {
  description = "Banco consumido pela aplicação, vindo da camada 02"
  value       = data.terraform_remote_state.infra.outputs.db_endpoint
}
