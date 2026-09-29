output "cache_id" {
  description = "Identificador do cluster de cache"
  value       = aws_elasticache_cluster.this.cluster_id
}

output "cache_endpoint" {
  description = "Endpoint de configuração do cache"
  value       = try(aws_elasticache_cluster.this.configuration_endpoint, null)
}
