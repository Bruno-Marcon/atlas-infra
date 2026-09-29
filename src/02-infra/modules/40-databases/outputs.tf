output "tabela_catalogo_name" {
  description = "Nome da tabela de catálogo"
  value       = aws_dynamodb_table.catalogo.name
}

output "tabela_catalogo_arn" {
  description = "ARN da tabela de catálogo"
  value       = aws_dynamodb_table.catalogo.arn
}

output "tabela_idempotencia_name" {
  description = "Nome da tabela de idempotência"
  value       = aws_dynamodb_table.idempotencia.name
}

output "db_identifier" {
  description = "Identificador da instância de banco"
  value       = aws_db_instance.principal.identifier
}

output "db_endpoint" {
  description = "Endpoint do banco"
  value       = aws_db_instance.principal.endpoint
}

output "db_secret_arn" {
  description = "Cofre com as credenciais do banco"
  value       = aws_secretsmanager_secret.banco.arn
}
