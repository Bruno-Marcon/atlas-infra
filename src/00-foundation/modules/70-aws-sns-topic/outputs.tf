output "sns_name" {
  description = "Nome do tópico de infraestrutura"
  value       = aws_sns_topic.infra.name
}

output "sns_arn" {
  description = "ARN do tópico — consumido pelas camadas 03 e 04"
  value       = aws_sns_topic.infra.arn
}
