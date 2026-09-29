output "repositorios_url" {
  description = "URL de cada repositório de imagem"
  value       = { for k, v in aws_ecr_repository.componente : k => v.repository_url }
}

output "repositorios_arn" {
  description = "ARN de cada repositório"
  value       = { for k, v in aws_ecr_repository.componente : k => v.arn }
}
