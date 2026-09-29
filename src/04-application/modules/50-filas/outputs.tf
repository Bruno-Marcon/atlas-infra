output "fila_url" {
  description = "URL da fila de trabalho"
  value       = aws_sqs_queue.trabalho.id
}

output "fila_arn" {
  description = "ARN da fila de trabalho"
  value       = aws_sqs_queue.trabalho.arn
}

output "dlq_url" {
  description = "URL da dead-letter queue"
  value       = aws_sqs_queue.dlq.id
}
