output "zone_id" {
  description = "ID da zona privada"
  value       = aws_route53_zone.privada.zone_id
}

output "zone_name" {
  description = "Domínio da zona privada"
  value       = aws_route53_zone.privada.name
}
