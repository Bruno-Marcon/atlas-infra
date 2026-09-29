output "certificado_arn" {
  description = "ARN do certificado do ambiente"
  value       = aws_acm_certificate.app.arn
}

output "certificado_dominio" {
  description = "Domínio coberto pelo certificado"
  value       = aws_acm_certificate.app.domain_name
}
