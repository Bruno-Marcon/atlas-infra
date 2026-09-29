output "log_group_name" {
  description = "Log group da aplicação"
  value       = aws_cloudwatch_log_group.app.name
}

output "log_group_auditoria_name" {
  description = "Log group de auditoria"
  value       = aws_cloudwatch_log_group.auditoria.name
}

output "queue_notificacao_arn" {
  description = "Fila assinante do tópico de infraestrutura"
  value       = aws_sqs_queue.notificacao.arn
}
