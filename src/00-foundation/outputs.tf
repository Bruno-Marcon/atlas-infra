################################################################################
# VPC
################################################################################
output "vpc_id" {
  description = "ID da VPC criada nesta camada"
  value       = module.network.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR da VPC"
  value       = module.network.vpc_cidr_block
}

output "subnet_public_ids" {
  description = "IDs das subnets públicas"
  value       = module.network.subnet_public_ids
}

output "subnet_private_ids" {
  description = "IDs das subnets privadas"
  value       = module.network.subnet_private_ids
}

output "route_table_public_id" {
  description = "ID da route table pública, consumida pela camada 01"
  value       = module.network.route_table_public_id
}

################################################################################
# SNS
################################################################################
output "sns_infra_arn" {
  description = "ARN do tópico de notificação, consumido pelas camadas 03 e 04"
  value       = module.sns-topic.sns_arn
}

################################################################################
# Audit Storage
################################################################################
output "audit_bucket_id" {
  description = "Bucket de auditoria, destino de log de acesso das camadas seguintes"
  value       = module.audit-storage.bucket_id
}

output "security_group_app_id" {
  description = "Security group da aplicação — consumido por EKS, RDS e cache na camada 02"
  value       = module.network.security_group_app_id
}
