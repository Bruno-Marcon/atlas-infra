################################################################################
# DNS
################################################################################
output "zone_id" {
  description = "Zona privada do ambiente — consumida pelas camadas 03 e 04"
  value       = module.dns-zone.zone_id
}

output "zone_name" {
  description = "Domínio da zona privada"
  value       = module.dns-zone.zone_name
}

################################################################################
# IAM
################################################################################
output "app_role_arn" {
  description = "Role assumida pela aplicação"
  value       = module.iam.role_arn
}

output "app_role_name" {
  description = "Nome da role da aplicação"
  value       = module.iam.role_name
}

output "eks_node_role_arn" {
  description = "Role dos nós do cluster"
  value       = module.iam.eks_node_role_arn
}

################################################################################
# Kubernetes
################################################################################
output "cluster_name" {
  description = "Nome do cluster EKS"
  value       = module.kubernetes.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint da API do cluster"
  value       = module.kubernetes.cluster_endpoint
}

output "cluster_oidc_issuer" {
  description = "Issuer OIDC do cluster — base do IRSA na camada 03"
  value       = module.kubernetes.cluster_oidc_issuer
}

################################################################################
# Databases
################################################################################
output "db_endpoint" {
  description = "Endpoint do banco relacional"
  value       = module.databases.db_endpoint
}

output "db_secret_arn" {
  description = "Cofre com as credenciais do banco"
  value       = module.databases.db_secret_arn
}

output "tabela_catalogo_name" {
  description = "Tabela NoSQL principal"
  value       = module.databases.tabela_catalogo_name
}

output "tabela_catalogo_arn" {
  description = "ARN da tabela NoSQL principal"
  value       = module.databases.tabela_catalogo_arn
}

################################################################################
# Registry e cache
################################################################################
output "repositorios_url" {
  description = "URL dos repositórios de imagem"
  value       = module.container-registry.repositorios_url
}

output "cache_endpoint" {
  description = "Endpoint do cache"
  value       = module.cache.cache_endpoint
}
