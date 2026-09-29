output "registros_publicados" {
  description = "Nomes publicados na zona do ambiente"
  value       = [for r in aws_route53_record.app : r.name]
}
