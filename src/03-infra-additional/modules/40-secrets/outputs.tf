output "secret_arn" {
  description = "ARN do segredo da aplicação"
  value       = aws_secretsmanager_secret.app.arn
}

output "secret_name" {
  description = "Nome do segredo da aplicação"
  value       = aws_secretsmanager_secret.app.name
}

output "parametros_paths" {
  description = "Caminhos publicados no parameter store"
  value       = [for p in aws_ssm_parameter.aplicacao : p.name]
}
