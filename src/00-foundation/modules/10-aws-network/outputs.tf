output "vpc_id" {
  description = "ID da VPC"
  value       = aws_vpc.this.id
}

output "vpc_cidr_block" {
  description = "CIDR da VPC"
  value       = aws_vpc.this.cidr_block
}

output "subnet_public_ids" {
  description = "IDs das subnets públicas"
  value       = aws_subnet.public[*].id
}

output "subnet_private_ids" {
  description = "IDs das subnets privadas"
  value       = aws_subnet.private[*].id
}

output "route_table_public_id" {
  description = "Route table pública — a camada 01 acrescenta rotas nela"
  value       = aws_route_table.public.id
}

output "security_group_app_id" {
  description = "Security group da aplicação"
  value       = aws_security_group.app.id
}
