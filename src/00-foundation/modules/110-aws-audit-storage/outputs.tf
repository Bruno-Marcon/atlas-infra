output "bucket_id" {
  description = "Nome do bucket de auditoria"
  value       = aws_s3_bucket.audit.id
}

output "bucket_arn" {
  description = "ARN do bucket de auditoria"
  value       = aws_s3_bucket.audit.arn
}
